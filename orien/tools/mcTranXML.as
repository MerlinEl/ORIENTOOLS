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
		
		static public function getItemByName(xml:XMLList, item_name:String):XML {
			
			for each (var item:XML in xml)
				if (item.@name == item_name) return item;
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
			var item:XML;
			for each (item in xml.children()) {
				
				var object:Object = {
					
					data: item, order: item.attribute(attribute)};
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
	}
}