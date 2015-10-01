

package configuration {

import flash.events.*;
import flash.net.*;

public class Configuration extends HashMap {

    private var isLoaded:Boolean;

    public function Configuration() {
        super();
        isLoaded = false;
    }

    public function setLoaded(loaded:Boolean):void {
        isLoaded = loaded;
    }

    public function getLoaded():Boolean {
        return isLoaded;
    }

    public function getConfigurationByKey(key:String):String {
        var ret:String;
        for (;key.lastIndexOf(".")!=-1;key = key.substring(0,key.lastIndexOf(".")-1)) {
            ret = getValue(key);
            if (ret != "") break;
        }
        return ret;
    }

    public function loadXML(key:String,handler:Function):void {
        var path:String = getConfigurationByKey(key);
        
        function loadConfigurationHandler(e:Event):void {
            handler(new XML(e.target.data));
        }

        var loader:URLLoader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, loadConfigurationHandler)
        loader.load(new URLRequest(path));
    }

}
}