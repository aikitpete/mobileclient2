package components.media {

import mx.controls.Image;
import mx.events.PropertyChangeEvent;
import mx.binding.utils.BindingUtils;
import components.actionstore.*;

public class Still extends Image implements IUpdatable, IActionStore  {

    private var actions:ActionStore;

    [Bindable] public var url:String;

    public function Still() {
        super();
        BindingUtils.bindSetter(load,this,"url");
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