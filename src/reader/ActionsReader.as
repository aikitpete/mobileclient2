package reader{

import uidocument.commons.api.document.*;
import uidocument.DocumentObjectFactory;

public class ActionsReader extends PropertiesReader {

    public function ActionsReader(dReader:UIDocumentReader) {
        //super(dReader);
        init(dReader);
    }

    public function processAction(xml:XML, model:ModelUpdate):Action {
        var action:Action = DocumentObjectFactory.createAction(xml);
        action.addModelUpdate(model);
        return action;
    }

}
}