
import UIKit

class AddAdvertisementCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    var parentCoordinator: Coordinator?
    private var completion: (UIImage) -> Void = {_ in }
    
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        
        let controller: AddAdvertisementController = .init()
        controller.viewModel.coordinator = self
        controller.viewModel.isInTabBar = true
        navigationController.pushViewController(controller, animated: false)
    }
    
    func present() {
        modalNavigationController = UINavigationController()
        modalNavigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: Asset.normalTextColor.color
        ]
        
        let controller: AddAdvertisementController = .init()
        modalNavigationController?.setViewControllers([controller], animated: false)
        controller.viewModel.coordinator = self
        controller.viewModel.isInTabBar = false
        modalNavigationController?.modalPresentationStyle = .fullScreen
        modalNavigationController?.hidesBottomBarWhenPushed = true
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: true)
        }
    }
    
    func showImagePickerForTab(completion: @escaping(UIImage) -> Void){
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController)
        imagePickerCoordinator.onFinishPickingImage = { image in
            self.completion(image)
        }
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.start()
    }
    
    
    func showImagePicker(completion: @escaping(UIImage) -> Void){
        guard let modalNavigationController = modalNavigationController else { return }
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
        imagePickerCoordinator.onFinishPickingImage = { image in
            self.completion(image)
        }
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.start()
    }
    
    func showAlert(){
        let ac = UIAlertController(title: "Жарнама ийгиликтүү жарыяланды", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ок", style: .default){ [weak self] _ in
            self?.start()
        })
        navigationController.present(ac, animated: true)
    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(self)
        navigationController.dismiss(animated: true)
    }
}
