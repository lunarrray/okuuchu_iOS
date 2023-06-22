
import UIKit

class AddAdvertisementController: VMController<AddAdvertisementPresentable, AddAdvertisementViewModelInput> {
    
    //MARK: - Properties
    
    private var tableViewManager: AddAdvertisementTableViewManager?
    private var originalFrame: CGRect?
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewManager = AddAdvertisementTableViewManager()
        content.tableView.dataSource = tableViewManager
        content.tableView.delegate = tableViewManager
        
        viewModel.setAdvertisement()
        tableViewManager?.delegate = self
        
        setupKeyboardDismissGesture()
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if isMovingFromParent {
            viewModel.viewDidDisappear()
        }
        
        view.endEditing(true)
    }
    
    
    //MARK: - Override methods
    
    override func onConfigureController() {
        navigationItem.title = "Жарнама кошуу"
        navigationItem.leftBarButtonItem = content.navigation.cancelButton
        navigationItem.rightBarButtonItem = content.navigation.addButton
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.handleCancelButtonTapAction = viewModel.cancelAddingVideo
        content.handleAddButtonTapAction = viewModel.addAdvertisement
    }
    
    //    deinit {
    //        unregisterKeyboardNotifications()
    //    }
    
}

//MARK: - Extension

extension AddAdvertisementController: AddAdvertisementViewModelOutput {
    func customizeOutput(with advertisementData: [TitleSubtitleViewModel], image: TitleSubtitleViewModel, activeTabBar: Bool) {
        tableViewManager?.setData(advertisementData, tableView: content.tableView)
        content.setImage(with: image)
        content.tabBarMode(isActive: activeTabBar)
    }
    
    func setImage(image: TitleSubtitleViewModel){
        content.setImage(with: image)
    }
    
    func choseLocation(_ locations: [Location]) {
        let ac = UIAlertController(title: "Жайгашкан жер тандоо", message: nil, preferredStyle: .actionSheet)
        for location in locations {
            ac.addAction(UIAlertAction(title: location.title, style: .default, handler: setLocation))
        }
        ac.addAction(UIAlertAction(title: "Баш тартуу", style: .cancel))
        present(ac, animated: true)
    }
    
    func selectItems(from items: [String], selection: Selection) {
        let ac = UIAlertController(title: selection.title, message: nil, preferredStyle: .actionSheet)
        for item in items {
            ac.addAction(UIAlertAction(title: item, style: .default) { [weak self] _ in
                self?.viewModel.selected(item: item, for: selection)
            })
        }
        ac.addAction(UIAlertAction(title: "Баарын очуруу", style: .default) { [weak self] _ in
            self?.viewModel.clearData(for: selection)
        })
        ac.addAction(UIAlertAction(title: "Баш тартуу", style: .cancel))
        present(ac, animated: true)
    }
}

extension AddAdvertisementController: AddAdvertisementTableViewDelegate {
    func updateCell(for indexPath: IndexPath, subtitle: String){
        let index = indexPath.row
        viewModel.updateCell(for: index, subtitle: subtitle)
    }
}

extension AddAdvertisementController {
    
    @objc private func setLocation(action: UIAlertAction) {
        if let actionTitle = action.title {
            viewModel.setLocation(actionTitle)
        }
    }
    
    private func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension AddAdvertisementController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // Dismiss the keyboard when the scroll view is being dragged
        view.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Adjust the content inset to avoid the keyboard
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: scrollView.keyboardInset, right: 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
}

extension UIScrollView {
    var keyboardInset: CGFloat {
        let bottomInset: CGFloat
        if #available(iOS 11.0, *) {
            bottomInset = adjustedContentInset.bottom
        } else {
            bottomInset = contentInset.bottom
        }
        return max(0, bottomInset - safeAreaInsets.bottom)
    }
}



//
//import UIKit
//
//class AddAdvertisementController: VMController<AddAdvertisementPresentable, AddAdvertisementViewModelInput> {
//
//    //MARK: - Properties
//
//    private var tableViewManager: AddAdvertisementTableViewManager?
//    private var originalFrame: CGRect?
//
//
//    //MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableViewManager = AddAdvertisementTableViewManager()
//        content.tableView.dataSource = tableViewManager
//        content.tableView.delegate = tableViewManager
//
//        viewModel.setAdvertisement()
//        tableViewManager?.delegate = self
//
//        registerKeyboardNotifications()
//
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        if isMovingFromParent {
//            viewModel.viewDidDisappear()
//        }
//    }
//
//
//    //MARK: - Override methods
//
//    override func onConfigureController() {
//        navigationItem.title = "Жарнама кошуу"
//        navigationItem.leftBarButtonItem = content.navigation.cancelButton
//        navigationItem.rightBarButtonItem = content.navigation.addButton
//    }
//
//    override func onConfigureViewModel() {
//        viewModel.output = self
//    }
//
//    override func onConfigureActions() {
//        content.handleCancelButtonTapAction = viewModel.cancelAddingVideo
//        content.handleAddButtonTapAction = viewModel.addAdvertisement
//    }
//
////    deinit {
////        unregisterKeyboardNotifications()
////    }
//
//}
//
////MARK: - Extension
//
//extension AddAdvertisementController: AddAdvertisementViewModelOutput {
//    func customizeOutput(with advertisementData: [TitleSubtitleViewModel], image: TitleSubtitleViewModel, activeTabBar: Bool) {
//        tableViewManager?.setData(advertisementData, tableView: content.tableView)
//        content.setImage(with: image)
//        content.tabBarMode(isActive: activeTabBar)
//    }
//
//    func setImage(image: TitleSubtitleViewModel){
//        content.setImage(with: image)
//    }
//
//    func choseLocation(_ locations: [Location]) {
//        let ac = UIAlertController(title: "Жайгашкан жер тандоо", message: nil, preferredStyle: .actionSheet)
//        for location in locations {
//            ac.addAction(UIAlertAction(title: location.title, style: .default, handler: setLocation))
//        }
//        ac.addAction(UIAlertAction(title: "Баш тартуу", style: .cancel))
//        present(ac, animated: true)
//    }
//
//    func selectItems(from items: [String], selection: Selection) {
//        let ac = UIAlertController(title: selection.title, message: nil, preferredStyle: .actionSheet)
//        for item in items {
//            ac.addAction(UIAlertAction(title: item, style: .default) { [weak self] _ in
//                self?.viewModel.selected(item: item, for: selection)
//            })
//        }
//        ac.addAction(UIAlertAction(title: "Баарын очуруу", style: .default) { [weak self] _ in
//            self?.viewModel.clearData(for: selection)
//        })
//        ac.addAction(UIAlertAction(title: "Баш тартуу", style: .cancel))
//        present(ac, animated: true)
//    }
//}
//
//extension AddAdvertisementController: AddAdvertisementTableViewDelegate {
//    func updateCell(for indexPath: IndexPath, subtitle: String){
//        let index = indexPath.row
//        viewModel.updateCell(for: index, subtitle: subtitle)
//    }
//}
//
//extension AddAdvertisementController {
//
//    private func registerKeyboardNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    private func unregisterKeyboardNotifications() {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    @objc private func setLocation(action: UIAlertAction) {
//        if let actionTitle = action.title {
//            viewModel.setLocation(actionTitle)
//        }
//    }
//
//    @objc private func keyboardWillShow(_ notification: Notification) {
//        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
//            return
//        }
//
//        if originalFrame == nil {
//            originalFrame = view.frame
//        }
//
//        let keyboardHeight = keyboardFrame.height
//        let adjustedFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - keyboardHeight)
//        UIView.animate(withDuration: 0.3) {
//            self.view.frame = adjustedFrame
//        }
//    }
//
//    @objc private func keyboardWillHide(_ notification: Notification) {
//           if let originalFrame = originalFrame {
//               UIView.animate(withDuration: 0.3) {
//                   self.view.frame = originalFrame
//               }
//           }
//       }
//}
