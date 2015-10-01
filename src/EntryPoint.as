package {
import mx.core.*;

public class EntryPoint {
    public static function main():void {
        trace("application.xml started");
        var client:UIClient = new UIClient();
        var mxmlApp:Application = Application(Application.application);
        mxmlApp.addChild(client);
    }
}
}