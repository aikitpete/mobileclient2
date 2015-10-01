package components.actionstore {
import components.*;

public class ActionStore implements IActionStore {

    private var actions:Vector.<Action>;

    public function ActionStore() {
        actions = new Vector.<Action>;
    }

    public function getBehavior(trigger:String):Action {
        for (var i:Number = 0; i < actions.length; i++) {
            if (actions[i].getTrigger()==trigger) {
                return actions[i];
            }
        }
        return null;
    }

    public function addBehavior(action:Action):void {
        actions.push(action);
    }

    public function removeBehavior(trigger:String):void {
        /*
        for (var i:Number = 0; i < actions.length; i++) {
            if (actions[i].getTrigger()==trigger) {
                actions.;
                return;
            }
        }
        */
    }
}
}