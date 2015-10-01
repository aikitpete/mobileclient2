package writer {

import uidocument.commons.api.document.*;

public class PropertyWriter {



    public function PropertyWriter() {

    }

    public function processEvent(action:Action, bProperties:Property):XML {
        var xml:XML = new XML(<event/>);
        xml.@id=action.getId();
        for (var i:Number = 0; i < bProperties.getLength(); i++) {
            xml.appendChild(<property/>);
            xml.property[i].@name = bProperties.getProperty(i).getName();
            xml.property[i].@value = bProperties.getProperty(i).getValue();
        }
        return xml;
    }

    public function processRequest(type:String, classes:Array):XML {
        var xml:XML = new XML(<event/>);
        xml.@id="public.request."+type;
        xml.appendChild(<property/>);
        type = "";
        for (var i:Number = 0; i < classes.length; i++) {
            type = type+classes[i];
            if (i==classes.length-1) {
                break;
            }
            type = type+",";
        }
        xml.property[0].@name = "class";
        xml.property[0].@value = type;
        return xml;
    }

}
}