/* JavaScript for Frontend pages */
jQuery(document).ready(function($) {
	var params = aelia_eu_vat_assistant_params;
	// Determine on which address VAT should be calculated
	var tax_based_on = params.tax_based_on;
	var vat_country = '';
	// Convenience object to keep track of the self certification field element
	var $self_certification_element = $('#customer_location_self_certified_field');
	var $eu_vat_element;
	var $eu_vat_field;
	// The last VAT number entered in the VAT number field. Used to prevent validating the same number when it doesn't change
	var last_vat_number = '';

	// Test
	//params.ip_address_country = 'IE';

	/**
	 * Returns the country that will be used for EU VAT calculations.
	 *
	 * @return string
	 */
	var get_vat_country = function() {
		if((tax_based_on == 'shipping') &&  $('#ship-to-different-address input').is(':checked')) {
			var country_field_selector = '#shipping_country';
		}
		else {
			var country_field_selector = '#billing_country';
		}

		// Determine the country that will be used for tax calculation
		return $(country_field_selector).val();
	}

	/**
	 * Determines if there is enough evidence about customer's location to satisfy
	 * EU requirements.
	 *
	 * @return bool
	 */
	var sufficient_location_evidence = function() {
		var country_count = {};
		country_count[$('#billing_country').val()] = ++country_count[$('#billing_country').val()] || 1;

		// Take shipping country as evidence only if explicitly told so
		if(params.use_shipping_as_evidence && (params.use_shipping_as_evidence != 0)) {
			if($('#ship-to-different-address-checkbox').is(':checked') && ($('#shipping_country').length > 0)) {
				country_count[$('#shipping_country').val()] = ++country_count[$('#shipping_country').val()] || 1;
			}
		}
		country_count[params.ip_address_country] = ++country_count[params.ip_address_country] || 1;

		for(var country_id in country_count) {
			// We have sufficient evidence as long as we have at least a count of 2
			// for any given, non empty country
			if((country_id != '') && (country_count[country_id] >= 2)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Shows/hides the self-certification field, depending on the data entered on
	 * checkout page and the plugin settings.
	 */
	var update_self_certification_element = function() {
		var show_element = true;
		// If VAT number is valid, and option "hide self-certification when
		// VAT number is valid" is enabled, the self-certification field must
		// be hidden. It will be ignored at checkout
		if(($eu_vat_field) && $eu_vat_field.prop('valid') && (params.hide_self_cert_field_with_valid_vat == 1)) {
			show_element = false;
		}
		else {
			switch(params.show_self_cert_field) {
				case 'yes':
					show_element = true;
					break;
				case 'conflict-only':
					show_element = !sufficient_location_evidence();
					break;
			}
		}

		// Replace tokens in the self certification box, if any
		var self_cert_label = params.user_interface.self_certification_field_title;
		$self_certification_element
			.find('.self_certification_label')
			.html(self_cert_label.replace('{billing_country}',$('#billing_country option:selected').text()));

		if(show_element) {
			$self_certification_element.fadeIn();
		}
		else {
			$self_certification_element.fadeOut();
		}
	}

	/**
	 * Indicates if the VAT number field must be hidden (the field could have to
	 * be hidden because the customer in in shop's base country, and the admin
	 * configured the system to hide the VAT field in such case.
	 *
	 * @return bool
	 */
	var hide_vat_number_field = function() {
		return !params.show_eu_vat_number_for_base_country &&
					 (vat_country == params.shop_base_country);
	}

	/**
	 * Validates the VAT number entered by the customer and updates the checkout
	 * page according to the result.
	 */
	var validate_vat_number = function () {
		var vat_number = $eu_vat_field.val();
		// If the number has not changed since last time, skip the validation
		if((vat_country + vat_number) == last_vat_number) {
			return;
		}

		// Don't bother sending an Ajax request when the required values are
		// empty
		if((vat_country == '') || (vat_number.trim() == '')) {
			// Set the VAT number as "invalid". It can't be valid, if either the
			// country or the number is empty
			// @since 1.9.2.181212
			$eu_vat_field.prop('valid', false);

			// Only display an empty VAT number as "invalid" if it's
			// required
			// @since 1.9.3.181217
			if(is_vat_number_required(vat_country)) {
				$eu_vat_element.addClass('woocommerce-invalid');
			}
			// Update the display of the self certification element
			update_self_certification_element();

			$(document).trigger('wc_aelia_euva_eu_vat_number_validation_number_incomplete', vat_country, vat_number);

			return;
		}

		// Store the last validated number
		last_vat_number = vat_country + vat_number;
		var ajax_args = {
			'action': 'validate_eu_vat_number',
			'country': vat_country,
			'vat_number': vat_number,
			'_ajax_nonce': params._ajax_nonce
		};
		$.get(params.ajax_url, ajax_args, function(response) {
			//console.log(response);
			// Tag the field to indicate if it's valid or not
			var vat_number_valid = response ? response.valid : false;
			$eu_vat_field.prop('valid', vat_number_valid);
			// Highlight the VAT number field when the entered VAT number is not valid
			// @since 1.8.4.181009
			$eu_vat_element.toggleClass('woocommerce-invalid',  !vat_number_valid);

			// Update the display of the self certification element
			update_self_certification_element();

			// Trigger an event upon completion of validation
			// @since 1.7.15.171106
			$(document).trigger('wc_aelia_euva_eu_vat_number_validation_complete', response);
		})
		// Track unexpected errors in the VAT validation request
		// @since 1.9.0.181022
		.fail(function(response){
			console.log("VAT validation request failed", response);
		});
	}

	/**
	 * Indicates if the EU VAT field is required. The field is normally optional,
	 * but it can be required in several cases:
	 * - If it's configured as "required".
	 * - If it's configured as "required for the EU" and the billing country is in
	 *   the EU.
	 * - If it's configured as "required only if company is filled" and the company
	 *   field is filled.
	 *
	 * @param string vat_country The VAT country selected at checkout.
	 * @return bool
	 * @since 1.5.6.151230
	 */
	var is_vat_number_required = function(vat_country) {
		var vat_country_is_in_eu = ($.inArray(vat_country, params.eu_vat_countries) >= 0);

		$billing_company_field = $('form #billing_company');
		var company_field_filled = ($billing_company_field.length > 0) && ($billing_company_field.val().trim() != '');

		// If the VAT number field must be hidden, then it cannot be required
		if(hide_vat_number_field()) {
			return false;
		}

		var result =
			// Required in all cases
			(params.eu_vat_field_required == 'required') ||
			// Required for EU only, and country is in the EU
			((params.eu_vat_field_required == 'required_for_eu_only') && vat_country_is_in_eu) ||
			// Required if company is filled, and company is filled
			((params.eu_vat_field_required == 'required_if_company_field_filled') && company_field_filled) ||
			// Required if company is filled, and company is filled, but only for EU
			((params.eu_vat_field_required == 'required_if_company_field_filled_eu_only') && company_field_filled && vat_country_is_in_eu);

		return result;
	}

	/**
	 * Sets the handlers required for the validation of the EU VAT field.
	 *
	 * @param object eu_vat_element A jQuery object wrapping the EU VAT field.
	 */
	var set_eu_vat_field_handlers = function() {
		var eu_vat_countries = params.eu_vat_countries;
		switch(tax_based_on) {
			case 'billing':
				var event_selector = 'select#billing_country';
				break;
			case 'shipping':
				var event_selector = 'select#billing_country, select#shipping_country, input#ship-to-different-address-checkbox';
				break;
			default:
				var event_selector = 'select#billing_country';
		}
		event_selector = event_selector + ', #billing_company, #vat_number';

		$('form.checkout, #order_review').on('change', event_selector, function() {
			var previous_vat_country = vat_country;
			vat_country = get_vat_country();

			// If the EU VAT number is enabled, show, hide or validate it depending on
			// the selected country and its content
			if($eu_vat_element.length > 0) {
				var vat_field_required = is_vat_number_required(vat_country);

				// Hide or show the EU VAT element, depending on the country (field is visible
				// for EU only)
				if(vat_country &&
					 (($.inArray(vat_country, params.eu_vat_countries) >= 0) &&
					 // Show the VAT field also for base country, if configured to do so.
					 // If not, show it for all EU countries, except base country
					 !hide_vat_number_field()) ||
					 // Show VAT number if it's required
					 vat_field_required
					) {
					$eu_vat_element.fadeIn();
				}
				else {
					$eu_vat_element.fadeOut(function() {
						$eu_vat_field.val('');
					});
				}

				// Flag the VAT number field required via CSS, if needed. This will allow
				// WooCommerce to highlight it with a red border if it's required and
				// left empty
				// @since 1.5.6.151230
				if($eu_vat_element.is(':visible') && vat_field_required) {
					$eu_vat_element.find('.form-row').addClass('validate-required');
				}
				else {
					$eu_vat_element.find('.form-row').removeClass('validate-required');
				}

				// Validate the VAT number
				validate_vat_number();
			}

			// Show the self-certification field, depending on the selected VAT country
			if($self_certification_element.length > 0) {
				update_self_certification_element();
			}
		});

		if($eu_vat_element.length > 0) {
			// Validate EU VAT number on the fly
			$eu_vat_field.on('blur', function() {
				validate_vat_number();
			});
		}
	}

	// Show the EU VAT field on checkout
	if($('.woocommerce form.checkout').length > 0) {
		$eu_vat_element = $('#vat_number_field');
		if($eu_vat_element.length > 0) {
			// Store a reference to the VAT number field
			$eu_vat_field = $eu_vat_element.find('#vat_number');
		}

		if($self_certification_element.length > 0) {
			var $self_certification_description = $self_certification_element.find('.description');

			$self_certification_element.find('.woocommerce-input-wrapper').before($self_certification_description);
		}

		set_eu_vat_field_handlers();
		// Trigger an update of the checkout form to display the EU VAT field
		$('select#billing_country').change();
	}
});
