// @todo combined property, remove empty constructor
// @todo PUBLIC VAR DATA  change to PRIVATE
// @todo MODIFIERS  :modifiers
// @todo TYPES OF VALUES     colorType, paintType

package uidocument.commons.api.document {

import uidocument.commons.api.document.property.*;

public class Property {

    public var data:Vector.<IProperty>;


    public function Property(data:Property=null, copy:Boolean=true, modelId:String=""):void {
        if (data==null) {
            this.data = new Vector.<IProperty>();
        }  else {
            if (copy) {
                this.data = data.getData();
            } else {
                this.data = new Vector.<IProperty>();
                var property:IProperty;
                for (var i:Number = 0; i < data.getLength(); i++) {
                    property = data.getProperty(i);
                    this.data.push(new PropertyObject(property.getName(),modelId+":"+property.getName(),property.getModifiers()));        
                }
            }
        }
    }

    public function push(property:IProperty):void {
        data.push(property)
    }

    public function getData():Vector.<IProperty> {
        return data;
    }

    public function setData(data:Vector.<IProperty>):void {
        this.data = data;
    }

    public function getProperty(i:Number):IProperty {
        if (this.getLength() > i) return data[i];
        else return null;
    }

    public function getValue(i:Number):String {
        if (this.getLength() >= i) return data[i - 1].getValue();
        else return "";
    }

    public function getNumberValue(i:Number):Number {
        return int(getValue(i));
    }

    public function getPropertyByName(str:String):IProperty {
        for (var i:Number = 0; i < this.data.length; i++) {
            if (data[i].getName() == str) return data[i];
        }
        return null;
    }

    public function getValueByName(str:String):String {
        for (var i:Number = 0; i < this.data.length; i++)
            if (data[i].getName() == str) return data[i].getValue();
        return null;
    }

    public function getLength():Number {
        return data.length;
    }

    public function toString():String {
        var ret:String = "";
        for (var i:Number = 0; i < data.length; i++)
            ret = ret + data[i].getName() + ":" + data[i].getValue() + ",";
        return ret;
    }

    public function compare(property:Property):Boolean {
        return false;
    }
}
}