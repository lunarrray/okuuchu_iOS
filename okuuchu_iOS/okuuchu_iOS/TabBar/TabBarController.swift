
import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: - Properties
    
    var mainCoordinator: MainCoordinator?
    
    private let mainScreenCoordinator: MainScreenCoordinator = .init(navigationController: .init())
    private let savedAdsCoordinator: SavedAdsCoordinator = .init(navigationController: .init())
    private let addAdvertisementCoordinator: AddAdvertisementCoordinator = .init(navigationController: .init())
    private let lessonsListCoordinator: LessonsListCoordinator = .init(navigationController: .init())
    private let teacherProfileCoordinator: TeacherProfileCoordinator = .init(navigationController: .init())

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        setTabBarAppearance()
    }
    
    //MARK: - Private Methods
    
    private func setupViewControllers(){
        let coordinators: [Coordinator] = [
            mainScreenCoordinator,
            savedAdsCoordinator,
            addAdvertisementCoordinator,
            lessonsListCoordinator,
            teacherProfileCoordinator
        ]
        
        coordinators.forEach {
            $0.start()
        }
        
        let mainScreenController = mainScreenCoordinator.navigationController
        let savedAdsController = savedAdsCoordinator.navigationController
        let addAdvertisementController = addAdvertisementCoordinator.navigationController
        let lessonsListController = lessonsListCoordinator.navigationController
        let teacherProfileController = teacherProfileCoordinator.navigationController
        
        mainScreenController.tabBarItem = tabBarItemBuilder(title: "", icon: Asset.homeIcon.image, selectedIcon: Asset.selectedHomeIcon.image)
        savedAdsController.tabBarItem = tabBarItemBuilder(title: "", icon: Asset.savedItemsIcon.image, selectedIcon: Asset.selectedSavedItemsIcon.image)
        addAdvertisementController.tabBarItem = tabBarItemBuilder(title: "", icon: Asset.addIcon.image, selectedIcon: nil)
        lessonsListController.tabBarItem = tabBarItemBuilder(title: "", icon: Asset.playVideo.image, selectedIcon: Asset.selectedPlayVideo.image)
        teacherProfileController.tabBarItem = tabBarItemBuilder(title: "", icon: Asset.avatarIcon.image, selectedIcon: Asset.selectedAvatarIcon.image)
        
        viewControllers = [
            mainScreenController,
            savedAdsController,
            addAdvertisementController,
            lessonsListController,
            teacherProfileController
        ]
        
        mainCoordinator?.appendChildCoordinators(coordinators)
    }
    
    private func tabBarItemBuilder(title: String, icon: UIImage?, selectedIcon: UIImage?) -> UITabBarItem {
        let item = UITabBarItem(title: title, image: icon, selectedImage: selectedIcon)
        return item
    }
    
    private func setTabBarAppearance(){
        tabBar.addShadow()
        let width = tabBar.bounds.width * 0.95
        let height = tabBar.bounds.height * 1.5
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: (tabBar.bounds.width - width) / 2,
                y: tabBar.bounds.minY - 10,
                width: width,
                height: height),
                cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 3
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = Asset.darkBlue.color.cgColor
        tabBar.tintColor = Asset.white.color
        tabBar.unselectedItemTintColor = Asset.white.color
    }
}
