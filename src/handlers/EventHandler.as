package handlers {

import flash.events.MouseEvent;

public class EventHandler {

    private var trigger:String;
    private var asClass:String;
    private var asType:String;

    public function EventHandler(trigger:String, asClass:String, asType:String) {
        this.trigger = trigger;
        this.asClass = asClass;
        this.asType  = asType;
    }

    public function eventHandler (e:MouseEvent) :void {
        Display.getInstance().executeAction(e.currentTarget.getBehavior(trigger));
    }

    public function getAsClass():String {
        return asClass;
    }

    public function getAsType():String {
        return asType;
    }

}
}