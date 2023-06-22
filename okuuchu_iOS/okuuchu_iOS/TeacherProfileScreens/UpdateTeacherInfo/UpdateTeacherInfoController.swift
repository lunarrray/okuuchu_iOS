
import UIKit

class UpdateTeacherInfoController: VMController<UpdateTeacherInfoPresentable, UpdateTeacherInfoViewModelInput> {
    
    //MARK: - Properties
    
    private var tableViewManager: UpdateTeacherInfoTableViewManager?
    
    private var originalFrame: CGRect?

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewManager = UpdateTeacherInfoTableViewManager()
        content.tableView.dataSource = tableViewManager
        content.tableView.delegate = tableViewManager
        
        viewModel.getTeacherDataFromModel()
        tableViewManager?.delegate = self
        
        registerKeyboardNotifications()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.viewDidDisappear()
    }
    
    //MARK: - Override methods
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        
    }
    
    deinit {
        unregisterKeyboardNotifications()
    }
}

//MARK: - Extension

extension UpdateTeacherInfoController: UpdateTeacherInfoTableViewDelegate {
    
}

extension UpdateTeacherInfoController: UpdateTeacherInfoViewModelOutput {
    func customizeOutput(with dataSource: [Section]) {
        tableViewManager?.setTeacherData(dataSource, tableView: content.tableView)
    }
}

extension UpdateTeacherInfoController {
    
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
            self.content.reduceTableView()
            self.view.frame.origin.y = -keyboardFrame.height
        }
        
    }

    
    @objc private func keyboardWillHide(_ notification: Notification) {
        
        if let originalFrame = originalFrame {
            UIView.animate(withDuration: 0.3) {
                self.content.normalTableView()
                self.view.frame = originalFrame
            }
        }
    }
    
    @objc private func handleTapGesture() {
        view.endEditing(true)
    }
}
