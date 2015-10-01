// @todo synchronization
// @todo test conditions
package configuration {

import flash.events.*;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class ConfigurationReader extends EventDispatcher {

    private const CONFIG_FILE_PATH:String = "configuration/uiclientconfig.xml";

    private var uiTriggersPath:String;
    private var uiComponentsPath:String;
    private var uiElementsPath:String;
    private var uiModifiersPath:String;
    private var defaultModelsPath:String;
    private var defaultXMLsPath:String;

    private var dispatcher:EventDispatcher;

    private var uiTriggers:Configuration;
    private var uiComponents:Configuration;
    private var uiElements:Configuration;
    private var uiModifiers:Configuration;
    private var defaultModels:Configuration;
    private var defaultXMLs:Configuration;

    private static var instance:ConfigurationReader;

    public function ConfigurationReader() {
        super();
    }

    public static function getInstance():ConfigurationReader {
        if (instance == null) {
            instance = new ConfigurationReader();
        }
        return instance;
    }

    public function init():void {
        var readXML:XML;
        dispatcher = new EventDispatcher;
        uiTriggers = new Configuration();
        uiComponents = new Configuration();
        uiElements = new Configuration();
        uiModifiers = new Configuration();
        defaultModels = new Configuration();
        defaultXMLs = new Configuration();

        function loadConfigHandler(e:Event):void {

            readXML = new XML(e.target.data);
            uiTriggersPath = readXML.uitriggerspath.@value;
            uiComponentsPath = readXML.uicomponentspath.@value;
            uiElementsPath = readXML.uielementspath.@value;
            uiModifiersPath = readXML.uimodifierspath.@value;
            defaultModelsPath = readXML.defaultmodelspath.@value;
            defaultXMLsPath = readXML.defaultdocumentspath.@value;

            loadPaths(uiTriggers, uiTriggersPath);
            loadPaths(uiComponents, uiComponentsPath);
            loadPaths(uiElements, uiElementsPath);
            loadPaths(uiModifiers, uiModifiersPath);
            loadPaths(defaultModels, defaultModelsPath);
            loadPaths(defaultXMLs, defaultXMLsPath);

        }

        var loader:URLLoader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, loadConfigHandler)
        loader.load(new URLRequest(CONFIG_FILE_PATH));


    }

    private function loadPaths(h:Configuration, path:String):void {
        var readXML:XML;


        function loadPathsHandler(e:Event):void {
            readXML = new XML(e.target.data);
            for (var i:Number = 0; i < readXML.children().length(); i++) {
                if (readXML.children()[i].@name[0] && readXML.children()[i].@path[0]) {
                    h.put(readXML.children()[i].@name[0], readXML.children()[i].@path[0]);
                }
            }

            h.setLoaded(true);
            if (isLoaded()) { 
                dispatchEvent(new Event(Event.COMPLETE));
            }
        }

        var loader:URLLoader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, loadPathsHandler)
        loader.load(new URLRequest(path));
    }

    public function loadXML(type:String, key:String, handler:Function):void {
        if (type == ObjectType.DEFAULT_XML) {
            defaultXMLs.loadXML(key, handler);
        } else if (type == ObjectType.DEFAULT_MODEL) {
            defaultModels.loadXML(key, handler);
        }
    }

    public function getDefaultModels():Vector.<XML> {
        return null;
    }

    public function getTrigger(name:String):String {
        return uiTriggers.getValue(name);
    }

    public function getComponentClass(name:String):String {
        return uiComponents.getValue(name);
    }

    public function getElementClass(name:String):String {
        return uiElements.getValue(name);
    }

    public function getModifierClass(name:String):String {
        return uiModifiers.getValue(name);
    }

    public function getUITriggersPath():String {
        return uiTriggersPath;
    }

    public function getUIComponentsPath():String {
        return uiComponentsPath;
    }

    public function getUIElementsPath():String {
        return uiElementsPath;
    }

    public function getUIModifiersPath():String {
        return uiModifiersPath;
    }

    public function getDefaultModelsPath():String {
        return defaultModelsPath;
    }

    public function getDefaultDocumentsPath():String {
        return defaultXMLsPath;
    }

    public function isLoaded():Boolean {
        if (uiTriggers.getLoaded() == false) return false;
        if (uiComponents.getLoaded() == false) return false;
        if (uiElements.getLoaded() == false) return false;
        if (uiModifiers.getLoaded() == false) return false;
        if (defaultModels.getLoaded() == false) return false;
        if (defaultXMLs.getLoaded() == false) return false;
        return true;
    }

    public override function toString():String {
        var ret:String = "Configuration:\n";
        ret = ret + "Actions file:\t\t\t" + uiTriggersPath + "\nComponents file:\t\t\t" + uiComponentsPath + "\nElements file:\t\t\t" +
              uiElementsPath + "\nModifiers file:\t\t\t" + uiModifiersPath + "\nDefault models path:\t\t\t" + defaultModelsPath +
              "\nDefault XMLs path:\t\t\t" + defaultXMLsPath + "\n";
        ret = ret + "**Triggers**\n" + uiTriggers.toString() + "\n";
        ret = ret + "**Components classes**\n" + uiComponents.toString() + "\n";
        ret = ret + "**Elements classes**\n" + uiElements.toString() + "\n";
        ret = ret + "**Modifiers classes**\n" + uiModifiers.toString() + "\n";
        ret = ret + "**Models XMLs**\n" + uiElements.toString() + "\n";
        ret = ret + "**Default XMLs**\n" + uiModifiers.toString() + "\n";
        return ret;
    }

}
}