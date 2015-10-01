// @todo remove MODEL UPDATE

package writer{
import uidocument.commons.api.document.*;
import components.actionstore.Action;


public class UIDocumentWriter {

    private static var instance:UIDocumentWriter;

    public function UIDocumentWriter() {
        instance = this;
    }

    public static function getInstance():UIDocumentWriter {
        if (instance == null) {
            instance = new UIDocumentWriter();
        }
        return instance;
    }

    private function findAction(action:String):uidocument.commons.api.document.Action {
        var ret:uidocument.commons.api.document.Action = UIDocument.getInstance().findAction(action);
        if (ret == null) {
            writeRequest("action",new Array(action));
        }
        return ret;
    }

    public function writeRequest(type:String, classes:Array):void {
        sendMessage(EventsWriter.getInstance().writeRequestXML(type,classes));
    }

    public function executeAction(action:components.actionstore.Action):void {
        var uiAction:uidocument.commons.api.document.Action = findAction(action.getAction());
        UIDocument.getInstance().addModelUpdate(uiAction.getModelUpdate(0));
        if (uiAction.getExecution()=="server") {
            sendMessage(EventsWriter.getInstance().writeEventXML(uiAction,action.getProperties()));
        }
    }

    private function sendMessage(xml:XML):void {
        UIClientConnection.getInstance().send(xml);
    }

}
}