
import UIKit

class TranslucentOverlayView: BaseView {
    override func onConfigureView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
}
