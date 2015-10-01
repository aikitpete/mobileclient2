package {

import mx.containers.Canvas;
import writer.*;
import uidocument.commons.api.document.*;
import components.actionstore.Action;
import components.ComponentFactory;

public class Display extends Canvas {

    private static var instance:Display;

    public function Display() {
        super();
        instance = this;
    }

    public static function getInstance():Display {
        if (instance == null) {
            instance = new Display();
        }
        return instance;
    }

    public function init():void {
    }

    public function displayInterface(uInterface:Interface):void {
        for each (var n:Element in uInterface.getRoot().getChildren()) {
            //UIClient.debug("Displaying\n"+n.toString()+"\n");
            addChild(ComponentFactory.createUIElement(n));
            //UIClient.debug("Element displayed\n");
        }
    }

    public function executeAction (action:components.actionstore.Action):void {
        UIDocumentWriter.getInstance().executeAction(action);
    }

    override public function toString():String {
        return "width:"+this.width+",height"+this.height;
    }

}

}