
import Foundation

class LabelAndTextData {
    var title: String
    var text: String?
    var type: LabelAndTextDataType
    
    init(title: String, text: String?, type: LabelAndTextDataType) {
        self.title = title
        self.text = text
        self.type = type
    }
}

enum LabelAndTextDataType{
    case usual
    case withAddButton
    case withSwitch
    case variations
    case bigText
}
