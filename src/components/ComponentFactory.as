//@todo static
//@todo remove xxx:*
//@todo special elements
package components{

import flash.display.DisplayObject;
import flash.events.MouseEvent;
import components.*;
import components.media.*;
import mx.controls.*;
import uidocument.commons.api.document.UIDocument;
import uidocument.commons.api.document.Element;
import uidocument.commons.api.document.Property;
import uidocument.commons.api.document.Behavior;
import uidocument.commons.api.document.property.*;
import components.actionstore.Action;
import flash.utils.getDefinitionByName;
import configuration.ConfigurationReader;
import handlers.*;

public class ComponentFactory {

    private static var display:Display;
    private static var document:UIDocument;

    public static function createUIElement(element:Element):DisplayObject {

        var ClassObj:Class = getDefinitionByName(ConfigurationReader.getInstance().getComponentClass(element.getId())) as Class;
        var uiElement:DisplayObject = new ClassObj();
        setComponent(uiElement,element);
        return uiElement;

    }

    public static function setComponent(component:*, element:Element):void {
        component = setHandlers(setBehavior(setPosition(setProperties(component,element),element),element),element);
    }

    public static function setProperties(component:*, element:Element):DisplayObject {
        return readProperties(component,element.getProperties());
    }

    public static function setBehavior(component:*, element:Element):DisplayObject {
        return component;//readProperties(component,element.);
    }

    private static function setPosition(component:*, element:Element):DisplayObject {
        return readProperties(component,element.getPosition());
    }

    private static function readProperties(component:*, properties:Property):DisplayObject {
        var property:IProperty;
        for (var i:Number = 0; i<properties.getLength(); i++) {
            property = properties.getProperty(i);
            if (property.getValue().split(":").length == 1) {
                component[property.getName()]=property.getValue();
            } else {
                document.setBinding(property,component);
            }
        }
        return component;
    }

    public static function setHandlers(component:*, element:Element):DisplayObject {

        var behavior:Behavior;
        var handler:EventHandler;
        var ClassObj:Class;

        for (var i:Number = 0; i < element.getBehaviorLength(); i++) {
            behavior = element.getBehavior(i);
            component.addBehavior(new Action(behavior.getTrigger(),behavior.getAction(),behavior.getProperties()));

            handler = HandlerFactory.createHandler(behavior.getTrigger());
            ClassObj = getDefinitionByName(handler.getAsClass()) as Class;
            component.addEventListener(ClassObj[handler.getAsType()],handler.eventHandler);

        }
        return component;
    }

    public static function setDisplay(disp:Display):void {
        display = disp;
    }

    public static function setDocument(doc:UIDocument):void {
        document = doc;
    }

    /**
     * Function containing calls to constructors, which is never used, but necessary for the program to run
     */
    public static function unused():void {      
        new components.Text();
        new components.media.Still();
        new components.Button();
        new components.Input();

        new flash.events.MouseEvent(null);
    }

}
}