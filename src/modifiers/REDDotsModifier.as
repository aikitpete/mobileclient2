package modifiers{

import mx.events.PropertyChangeEvent;

public class REDDotsModifier extends Modifier {

    public function REDDotsModifier(suc:IUpdatable) {
        super(suc);
    }

    override public function update(val:PropertyChangeEvent):void {
        val.newValue = val.newValue + "...";
        successor.update(val);
    }
}
}