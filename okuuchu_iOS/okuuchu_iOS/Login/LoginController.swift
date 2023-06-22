
import UIKit

class LoginController: VMController<LoginPresentable, LoginViewModelInput> {
    
    private var originalFrame: CGRect?
    
    override func viewDidLoad() {
        
        registerKeyboardNotifications()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    override func onConfigureActions() {
        content.registerTapAction = handleRegisterTapAction
        content.loginTapAction = handleLoginTapAction
    }
    
    deinit {
        unregisterKeyboardNotifications()
    }
}

extension LoginController: LoginViewModelOutput {
    private func handleRegisterTapAction(){
        viewModel.openRegistration()
    }
    
    private func handleLoginTapAction(){
        viewModel.openMainScreen()
    }
        
}

extension LoginController {
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        


    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        if originalFrame == nil {
            originalFrame = view.frame
        }
        
        UIView.animate(withDuration: 0.2) {
            self.view.frame.origin.y = -keyboardFrame.height
        }
        
    }

    
    @objc private func keyboardWillHide(_ notification: Notification) {
        
        if let originalFrame = originalFrame {
            UIView.animate(withDuration: 0.3) {
                self.view.frame = originalFrame
            }
        }
    }
    
    @objc private func handleTapGesture() {
        view.endEditing(true)
    }
}
