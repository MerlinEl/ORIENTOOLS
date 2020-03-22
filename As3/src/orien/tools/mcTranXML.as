package orien.tools {
	
	/**
	 * ...
	 * @author Orien
	 */
	public class mcTranXML { //exparimentální verze, used at iFrame_Toolbar
		
		public var DEBUG:int = 0
		
		public function mcTranXML() {
		
		}
		
		static public function getItemIndex(xml:XML, item_name:String):int {
			
			for each (var item:XML in xml.children()) {
				if (item.@name == item_name) return item.childIndex();
			}
			return -1;
		}
		
		/*static public function getItemIndexAtr(xml:XML, item_name:String, param:String):int {
		
		   for each (var item:XML in xml.children()) {
		   if (item.attribute(param) == item_name) return item.childIndex();
		   }
		   return -1;
		   }*/
		
		/**
		 * @example
		 * var item:XML = mcTranXML.getItemByName(product_xml.elements(), "book_1");
		 * @param	xml
		 * @param	item_name
		 * @return
		 */
		static public function getItemByName(xml:XMLList, item_name:String):XML {
			
			for each (var item:XML in xml)
				if (item.@name == item_name) return item;
			return null;
		}
		
		static public function getItemByLabel(xml:XMLList, item_label:String, ignore_case:Boolean = false):XML {
			
			for each (var item:XML in xml)
			
				if (ignore_case){
					
					if (String(item.@label).toLowerCase() == item_label.toLowerCase()) return item;
				} else {
					
					if (item.@label == item_label) return item;
				}		
			return null;
		}
		
		static public function getXMLListItemByAttribute(xml:XMLList, item_label:String, param:String):XML {
			
			for each (var item:XML in xml)
				if (item.attribute(param) == item_label) return item;
			return null;
		}
		
		/*static public function replaceItemAt(xml:XML, index:int, new_item:XML):void {
		   //
		   xml.replace(item_name, new_item);
		   }*/
		
		static public function addItem(xml:XML, new_item:XML):void {
			
			xml.appendChild(new_item);
		}
		
		static public function addItemAt(xml:XML, index:int, new_item:XML):void {
			
			xml.child[index] = new_item;
		}
		
		/**
		 * Add new node in to XMLList (list must be replaced after return)
		 * @param	list XMLList
		 * @param	xml new XML node
		 * @return	populated XMLList
		 */
		static public function addToXMLList(list:XMLList, xml:XML):XMLList {
			
			list += xml;
			return list;
		}
		//mcTranXML.removeFromXMLListByAttribute(xml.Books[book_name].item, itm_name, "label");
		static public function removeFromXMLListByAttribute(list:XMLList, item_name:String, param:String):void {
			
			for (var i:int = 0; i < list.length(); i++) {
				
				if (list[i].attribute(param) == item_name) delete list[i];
			}
		}
		
		/*static public function addReplace(xml:XML, item_name:String, new_group:XML):void {
		   //get item index by name
		   //if exist replace if not add
		   removeItemByName(xml, item_name);
		   addItem(xml, new_group);
		
		   }*/
		
		/**
		 * Remove item by given name (works fine , but be carefull and check result)
		 * @param	xml
		 * @param	item_name
		 */
		static public function removeItemByName(xml:XML, item_name:String):void {
			
			var index:int = getItemIndex(xml, item_name);
			if (index != -1) delete xml.children()[index];
		}
		
		/*static public function removeItemByAttribute(xml:XML, item_name:String, param:String):void {
		
		   var index:int = getItemIndexAtr(xml, item_name, param);
		   if (index != -1) delete xml.children()[index];
		   }*/
		
		/**
		 * Sort keys xml by her attribute : label, name, ...
		 * @param	xml
		 * @param	attribute
		 * @param	options Array.NUMERIC ...
		 * @param	clone
		 * @return
		 */
		static public function sortXMLByAttribute(xml:XML, attribute:String, options:Object = null, clone:Boolean = false):XML {
			
			//store in array to sort on
			var xmlArray:Array = new Array();
			for each (var item:XML in xml.children()) {
				
				var object:Object = { "data": item, "order": item.attribute(attribute) };
				xmlArray.push(object);
			}
			//sort using the power of Array.sortOn()
			xmlArray.sortOn('order', options);
			
			//create a new XMLList with sorted XML
			var sortedXmlList:XMLList = new XMLList();
			var xmlObject:Object;
			for each (xmlObject in xmlArray) {
				
				sortedXmlList += xmlObject.data;
			}
			if (clone) {
				//don't modify original
				return xml.copy().setChildren(sortedXmlList);
			} else {
				//original modified
				return xml.setChildren(sortedXmlList);
			}
		}
		//works only for root xml keys
		static public function removeXMLListByName(xml:XML, key:String):void {
			
			//trace("Original xml:"+xml.toXMLString());
			var child:XMLList = xml.child(key);
			//trace("XMLList:"+child.toXMLString());
			delete child[0];
			//trace("Modified xml:"+xml.toXMLString());
		}
		
		/**
		 * Remove given XMLList from XML
		 * @example	mcTranXML.removeXMLList(xml.Books[sel_book.selectedItem.id])
		 * @param	list XMLList
		 */
		static public function removeXMLList(list:XMLList):void {
			
			delete list[0];
		}
		
		/**
		 * Remove all XML nodes from XMLList
		 * @example	mcTranXML.clearXMLList(xml.Books[sel_book.selectedItem.id])
		 * @param	list XMLList
		 */
		static public function clearXMLList(list:XMLList):void {
			
			list.setChildren(new XMLList());	
		}
		
		static public function mergeXMLLists(xmllist_array:Array):XMLList{
			
			var new_list:XMLList = new XMLList();
			for each (var xml_list:XMLList in xmllist_array){
				
				for each (var xml:XML in xml_list) {
					
					new_list += xml;
				}
			}
			return new_list;
		}
	}
}

/*
   trace("---Example 1 : for each in---");
   for each(var a:XML in xml1.@*)
   {
   trace (a.name() + " : " + a.toXMLString());
   }

   trace("---Example 2 : for---");
   var atts:XMLList = xml1.attributes();
   for (var i:int = 0; i < atts.length(); i++)
   {
   trace (String(atts[i].name()) + " : " + atts[i].toXMLString());
   }
 */