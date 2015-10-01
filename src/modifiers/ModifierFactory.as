package modifiers {

import configuration.ConfigurationReader;
import flash.utils.getDefinitionByName;


public class ModifierFactory {
    
    public static function createModifier(modifierName:String, previousSetter:IUpdatable):Modifier {
        var ClassObj:Class = getDefinitionByName(ConfigurationReader.getInstance().getModifierClass(modifierName)) as Class;
        var mod:Modifier = new ClassObj(previousSetter);
        return mod;

    }


    /**
     * Function containing calls to constructors, which is never used, but necessary for the program to run
     */
    public function unused():void {
        new LowercaseModifier(null);
        new UppercaseModifier(null);
        new CapitalModifier(null);
    }

}
}