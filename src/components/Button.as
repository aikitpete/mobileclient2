package components {

//import uidocument.commons.api.document.*;
import mx.controls.*;
import mx.events.PropertyChangeEvent;
import mx.binding.utils.BindingUtils;
import components.actionstore.*;

public class Button extends mx.controls.Button implements IUpdatable, IActionStore {

    private var actions:ActionStore;

    public function Button():void {                               
        BindingUtils.bindProperty(this,"label",this,"name");
        actions = new ActionStore();
    }
        

    public function update(val:PropertyChangeEvent):void {
        this[val.property] = "" + val.newValue;
    }

    public function getBehavior(trigger:String):Action {
        return actions.getBehavior(trigger);
    }

    public function addBehavior(action:Action):void {
        actions.addBehavior(action);
    }

    public function removeBehavior(trigger:String):void {
        actions.removeBehavior(trigger);
    }
}
}