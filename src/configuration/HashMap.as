package configuration {








public class HashMap
{

    public var keys:Vector.<String>;
    public var values:Vector.<String>;

    public function HashMap() {
        super();
        this.keys = new Vector.<String>();
        this.values = new Vector.<String>();
    }

    public function containsKey(key:String):Boolean {
        return (this.findKeyIndex(key) > -1);
    }

    public function containsValue(value:String):Boolean {
        return (this.findValueIndex(value) > -1);
    }

    public function getValue (key:String):String {
        return (values[this.findKeyIndex(key)]);
    }

    public function put(key:String, value:String):void {
        var theKey:Number = this.findKeyIndex(key);
        if (theKey < 0) {
            this.keys.push(key);
            this.values.push(value);
        }
        else {
            this.values[theKey] = value;
        }
    }

    public function size():Number {
        return (this.keys.length);
    }

    public function isEmpty():Boolean {
        return (this.size() < 1);
    }

    public function findKeyIndex(key:String):Number {
        for (var i:Number = this.keys.length-1; i>-1; i--) {
            if (this.keys[i] == key) break;
        }
        return i;
    }

    public function findValueIndex(value:String):Number {
        for (var i:Number = this.keys.length-1; i>-1; i--) {
            if (this.values[i] == value) break;   
        }
        return i;
    }

    public function toString():String {
        var ret:String = "Stored values:\n";
        for (var i:Number = 0; i<this.keys.length; i++) {
            ret = ret+keys[i]+","+values[i]+";";    
        }
        return ret;
    }

}

}