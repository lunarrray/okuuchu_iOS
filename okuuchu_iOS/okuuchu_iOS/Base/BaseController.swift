
import UIKit

open class BaseController<View: UIView>: UIViewController{
    var content: View {
        view as! View
    }
    
    open override func loadView() {
        super.loadView()
        
        view = View()
        
        onConfigureController()
        onConfigureViewModel()
        onConfigureActions()
        
    }
    
    func onConfigureController() { }
    func onConfigureViewModel(){ }
    func onConfigureActions() { }
}

open class VMController<View: UIView, VMInput>: BaseController<View> {
    open lazy var viewModel: VMInput = Swinjectable.container.resolve(VMInput.self)!
}
