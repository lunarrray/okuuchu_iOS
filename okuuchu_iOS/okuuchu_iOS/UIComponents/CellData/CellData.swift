
import UIKit

class CellData{
    var title: String?
    var subtitle: String?
    var image: UIImage?
    
    init(title: String? = nil, subtitle: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}
