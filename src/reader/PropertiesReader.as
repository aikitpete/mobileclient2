// @todo implicitni hodnota property
// @todo check keys :
// @todo : in value
// @todo property inside tag
// @todo property DOMAIN SEPARATOR
package reader{

import uidocument.commons.api.document.*;
import uidocument.commons.api.document.property.*;
import uidocument.DocumentObjectFactory;

public class PropertiesReader {

    public static var dReader:UIDocumentReader;

    /*
    public function PropertiesReader(dReader:UIDocumentReader) {
        this.dReader = dReader
    }
    */

    public static function init(reader:UIDocumentReader):void {
        dReader = reader;
    }

    public static function processProperties(xml:XML, isModel:Boolean = false):Property {
        var property:Property = DocumentObjectFactory.createProperty();
        if (xml.properties.length() >= 1) {
            for (var i:Number = 0; i < xml.properties.length(); i++) {
                processValues(xml.properties[i], property);
            }
        }
        if (xml.property.length() >= 1) {
            for (var j:Number = 0; j < xml.property.length(); j++) {
                if (xml.property[j].@key.length() > 0)
                    property.push(processValue(xml.property[j].@name, xml.property[j].@key, isModel));
                else
                    property.push(processValue(xml.property[j].@name, xml.property[j].@value, isModel));
            }
        }
        return property;
    }

    public static function processValues(xml:XML, property:Property, isModel:Boolean = false):void {
        if (xml.@names.length() > 0) {
            var names:Array = xml.@names.split(",");
            var values:Array;
            if (xml.@values.length() != 0) {
                values = xml.@values.split(",");
            }
            else if (xml.@keys.length() != 0) {
                values = xml.@keys.split(",");
            }
            if (values.length != names.length)
                return;
            for (var i:Number = 0; i < names.length; i++) {
                property.push(processValue(names[i], values[i], isModel));
            }
        }
    }

    public static function processValue(name:String, value:String, isBindable:Boolean = false, isKey:Boolean = false):IProperty {
        if (name == "") return null;
        var modifiers:String = "";
        if (value.split(":", 3)[1]) {
            if (value.split(":", 3)[2]) {
                modifiers = value.split(/[^:]*:[^:]*:/, 2)[1];
            }
            value = value.split(":", 2)[0] + ":" + value.split(":", 3)[1];
        }
        if (!isBindable) {
            return new PropertyObject(name, value, modifiers);
        } else {
            var bindableProperty:BindablePropertyObject = new BindablePropertyObject(name, value);
            if (isKey) {                                                                  //binds model to another model
                UIDocument.getInstance().setBinding(bindableProperty, bindableProperty);
            }
            return bindableProperty;
        }
    }

    public static function getPropertyFromAction(query:String):Property {
        /*var action:Action = dReader.findAction(query);
         if (action!=null)
         return action.getVariant();
         else*/
        return null;
    }

    public static function getPropertyFromEvent(query:String):Property {
        /*var event:Event = dReader.findEvent(query);
         if (event!=null)
         return event.getVariant();
         else*/
        return null;
    }

    public static function getPropertyFromInterface(query:String):Property {
        /*var iface:Interface = dReader.findInterface(query);
         //if (iface!=null)
         //    return iface.getVariant();
         else*/
        return null;
    }

    public static function getPropertyFromModel(query:String):Property {
        var model:ModelUpdate = dReader.findModel(query);
        if (model != null) {
            return new Property(model.getVariant(), false, model.getId());
        } else {
            return null;
        }
    }

}
}