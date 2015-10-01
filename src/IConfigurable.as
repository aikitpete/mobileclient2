package {

import uidocument.commons.api.document.*;

public interface IConfigurable {
    function setProperties(properties:Property):void;

    function setPosition(position:Position):void;

    function setBehavior(behavior:Behavior):void;

    //function setLayout(properties:Property):void;
    function setAction(action:Action):void;
}
}