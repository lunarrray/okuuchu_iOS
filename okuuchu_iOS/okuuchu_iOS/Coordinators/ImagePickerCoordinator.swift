
import UIKit

final class ImagePickerCoordinator: NSObject, Coordinator {
    private(set)var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var onFinishPickingImage: (UIImage) -> Void = { _ in }
        
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.hidesBottomBarWhenPushed = true
        navigationController.present(imagePickerController, animated: true)
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("picking image")
        if let image = info[.originalImage] as? UIImage {
            onFinishPickingImage(image)
            navigationController.dismiss(animated: true)
        }
        parentCoordinator?.childDidFinish(self)
    }
}
