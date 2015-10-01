//@todo check container children
package reader{

import uidocument.commons.api.document.*;
import components.ComponentFactory;
import writer.UIDocumentWriter;
import uidocument.DocumentObjectFactory;
import configuration.*;

public class UIDocumentReader {

    private var document:UIDocument;
    private var display:Display;
    private var aReader:ActionsReader;
    private var eReader:EventsReader;
    private var iReader:InterfacesReader;
    private var mReader:ModelsReader;

    private var displayed:Boolean = false;

    private var writer:UIDocumentWriter;

    public function UIDocumentReader(display:Display, connection:UIClientConnection) {
        this.document = DocumentObjectFactory.createUIDocument();
        ComponentFactory.setDocument(document);
        this.display = display;
        writer = new UIDocumentWriter(document, connection);
        display.init(writer);
        this.aReader = new ActionsReader(this);
        this.eReader = new EventsReader(this);
        this.iReader = new InterfacesReader(this);
        this.mReader = new ModelsReader(this);
    }

    public function processDocument(xmlIn:XML):void {
        //if (document.getInterfaces().length == 0) 
        processMainContainer(xmlIn);
    }

    private function processMainContainer(xmlIn:XML):void {
        //UIClient.debug("TTT"+ConfigurationReader.getActionClass("pointer.click"));
        
        //UIClient.debug(xmlIn.defaultmodels.length() +"\n");
        //UIClient.debug(xmlIn.interfaces.length()+"\n");
        //UIClient.debug(xmlIn.actions.length() +"\n");
        if (xmlIn.models.length() != 0) {
                var mContainer:XML = xmlIn.models[0];
                for (var i:Number = 0; i < mContainer.children().length(); i++) {
                    document.addModelUpdate(mReader.processModel(mContainer.children()[i]));
                }
                UIClient.debug("Models processed");
        }
        if (xmlIn.interfaces.length() != 0) {
                var iContainer:XML = xmlIn.interfaces[0];
                for (var j:Number = 0; j < iContainer.children().length(); j++) {
                    document.addInterface(iReader.processInterface(iContainer.children()[j]));
                }
                UIClient.debug("Elements processed");
        }
        if (xmlIn.actions.length() != 0) {
                var aContainer:XML = xmlIn.actions[0];
                for (var k:Number = 0; k < aContainer.children().length(); k++) {
                    document.addAction(aReader.processAction(aContainer.children()[k], processModel(aContainer.children()[k].children()[0])));
                }
                UIClient.debug("Actions processed");
        }

        if (!displayed) {
            display.displayInterface(document.getInterfaces()[0]);
            displayed = true;
        }
    }

    public function processModel(xml:XML):ModelUpdate {
        return mReader.processModel(xml);
    }

    public function findAction(action:String):Action {
        return document.findAction(action);
    }

    public function findEvent(event:String):Event {
        return document.findEvent(event);
    }

    public function findInterface(iface:String):Interface {
        return document.findInterface(iface);
    }

    public function findModel(model:String):ModelUpdate {
        return document.findModel(model);
    }

}
}