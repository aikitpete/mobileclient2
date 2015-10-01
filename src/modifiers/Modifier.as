package modifiers{

import mx.events.PropertyChangeEvent;

//Abstract class

public class Modifier implements IUpdatable {

    protected var successor:IUpdatable;

    public function Modifier(suc:IUpdatable) {
        setSuccessor(suc);
    }

    public function setSuccessor(successor:IUpdatable):void {
        this.successor = successor;
    }

    public function update(val:PropertyChangeEvent):void {
        successor.update(val);
    }


}
}