package orien.tools {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import utils.JsonParser;
	
	/**
	 * ...
	 * @author René Bača 2016 (Orien)
	 */
	public dynamic class mcUMLTable extends EventDispatcher {
		
		private var _debug:Boolean = false;
		private var _correction:Boolean = false;
		private var all_folders:Object = {};
		private var _table:Object;
		
		public function mcUMLTable() {
		
		}
		
		public function readUML(fname:String):void {
			
			var url:URLRequest = new URLRequest(fname);
			var loader:URLLoader = new URLLoader();
			loader.load(url);
			loader.addEventListener(Event.COMPLETE, loaderComplete);
			function loaderComplete(e:Event):void {
				
				var umlData:Object = JsonParser.objFromJSON(loader.data as String);
				serialize(umlData);
				if (_debug) ftrace("PACK........................................")
				pack();
				if (_debug) {
					ftrace("END.........................................")
					
					ftrace("Remains undistributed folders in all_folders.........................................")
					printAllCards(); //temp
					ftrace("Distributed folders.........................................")
					print();
				}
				if (_correction) printXML();
				dispatchEvent(new mcCustomEvent(mcCustomEvent.FINISHED, this));
			}
		}
		
		private function printXML():void {
		
			var xml:XML = objToXML("DATA", _table);
			ftrace("XML:\n%", xml.toString());
		}
		
		private function serialize(data:Object):void {
			
			//ftrace("text:%", txt)
			
			//ftrace("data folders:% connectors:%", data.folders, data.connectors);
			//read folders
			if (_debug) ftrace("CREATE FOLDERS........................................")
			for each (var card:Object in data.cards) {
				
				all_folders[card.name] = new FOLDER(card.name, card.groups[0].text);
				if (_debug) trace( FOLDER(all_folders[card.name]) );
			}
			//read connectros and combine pairs with same parent
			if (_debug) ftrace("LINK FOLDERS........................................")
			for each (var item:Object in data.connectors) {
				
				var connector:CONNECTOR = new CONNECTOR(item.card_1, item.card_2);
				if (_debug) trace(connector);
				//define folder parent and childs (BUILD LINKS)
				var parent:FOLDER = all_folders[connector.parent] as FOLDER;
				var child:FOLDER = all_folders[connector.child] as FOLDER;
				parent.children.push(connector.child); //append child
				child.parent = connector.parent; //define parent
			}
		}
		
		private function pack():void {
			
			//move toplevel folders (folders without parent) in to new object (_table)
			_table = {};
			for each (var folder:FOLDER in all_folders) { //backwards
				
				if (_debug) ftrace("folder:% children:%", folder.name, folder.children.length)
				if (!folder.parent) {
					
					_table[folder.name] = folder; //clone top level folder in to new table
					delete all_folders[folder.name]; //remove folder from all_folders Object
				}
			}
			//move other folders in to their parents in all LEVELS
			recursivePackRest(_table);
		}
		
		private function recursivePackRest(container:Object):void {
			
			for each (var folder:FOLDER in container) {
				
				if (folder.children.length == 0) continue;
				if (_debug) ftrace("replacing folder:% children names:% len:%", folder.name, folder.children, folder.children.length);
				var new_children:Array = [];
				for each (var folder_name:String in folder.children) {
					
					new_children.push(all_folders[folder_name] as FOLDER); //clone folder in to new_children array
					delete all_folders[folder_name]; //remove folder from all_folders Object
				}
				folder.children = new_children; //replace children names with folders
				if (folder.children.length > 0) recursivePackRest(folder.children);
				if (_debug) ftrace("replaced folder:% children names:% len:%", folder.name, folder.children, folder.children.length);
			}
		}
		
		public function printAllCards():void {
			
			for each (var folder:FOLDER in all_folders) trace(folder);
		}
		
		public function getRandomCard(container:Object = null):FOLDER {
			
			if (!container) container = _table;
			var folders:mcArray = new mcArray();
			for each (var folder:FOLDER in container) {
				
				folders.addItem(folder);
			}
			folders.shuffle();
			return folders.pop() as FOLDER;
		}
		
		public function textToArray(text:String):Array {
			
			text = mcString.replaceAll(text, "\r", ""); //remove enters
			text = mcString.trimWhiteSpacesBeforeAfterDividers(text, [","]); //remove spaces before and after ","
			return text.split(",");
		}
		
		private function objToXML(name:String, folders:Object):XML {
			
			var xml:XML = <{name}/>;
			for each (var folder:FOLDER in folders) {
				
				//xml.appendChild(<{folder.name}>{folder.text}</{folder.name}>);
				xml.appendChild(<{folder.name}></{folder.name}>);
				xml[folder.name].@name = folder.text;
				if (folder.children.length == 0) continue;
				var node:XML = <{"children"}/>;
					var list:XMLList = new XMLList();
					var cnt:int = 0;
					for each(var subfolder:FOLDER in folder.children) {
						
						//list[cnt] = <{subfolder.name}>{subfolder.text}</{subfolder.name}>;
						list[cnt] = <{subfolder.name}></{subfolder.name}>;
						list[cnt].@name = subfolder.text;
					
						if (subfolder.children.length != 0) list[cnt].@words = mcString.replaceAll(subfolder.children[0].text, "\r", "");
						cnt++;
					}
				node.appendChild(list);
				xml[folder.name].appendChild(node);
			}
			return xml;
		}
		
		public function print(container:Object = null, level:int = 0):void {
			
			if (!container) container = _table;
			for each (var folder:FOLDER in container) {
				
				var t:String = tabs(level);
				ftrace(t + "% level:%", folder, level);
				if (folder.children.length != 0) print(folder.children, level + 1);
			}
		}
		
		private function tabs(cnt:int):String {
			
			var tab:String = "";
			for (var i:int = 0; i < cnt; i++) tab += "\t";
			return tab;
		}
	
	}
}

internal class CONNECTOR {
	
	private var _parent:String;
	private var _child:String;
	
	public function CONNECTOR(parent:String, child:String) {
		
		_parent = parent;
		_child = child;
	}
	
	public function toString() {

		return '{object CONNECTOR(parent:' + this.parent + ', child:' + this.child + ')}';
	}
	
	public function get parent():String {
		
		return _parent;
	}
	
	public function set parent(value:String):void {
		
		_parent = value;
	}
	
	public function get child():String {
		
		return _child;
	}
	
	public function set child(value:String):void {
		
		_child = value;
	}
}