package handlers {

import configuration.ConfigurationReader;
import flash.utils.getDefinitionByName;

public class HandlerFactory {


    public static function createHandler(trigger:String):EventHandler {

        var flashTrigger:String = ConfigurationReader.getInstance().getTrigger(trigger);
        var ClassObj:Class = getDefinitionByName("handlers.EventHandler") as Class;
        var handler:EventHandler = new ClassObj(trigger, flashTrigger.substring(0,flashTrigger.lastIndexOf(".")),
                flashTrigger.substring(flashTrigger.lastIndexOf(".")+1,flashTrigger.length));
        return handler;
    }

    /**
     * Function containing calls to constructors, which is never used, but necessary for the program to run
     */
    public function unused():void {
        new EventHandler(null,null,null);
    }

}
}