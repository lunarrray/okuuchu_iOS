
import UIKit

final class TutorAccountController: VMController<TutorAccountPresentable, TutorAccountViewModelInput> {
    
    //MARK: - Properties
    
    private var tutorInfoTableViewManager: TutorAccountTutorInfoTableViewManager?
    private var menuTableViewManager: TutorAccountMenuTableViewManager?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorInfoTableViewManager = TutorAccountTutorInfoTableViewManager()
        content.tutorInfoTableView.dataSource = tutorInfoTableViewManager
        content.tutorInfoTableView.delegate = tutorInfoTableViewManager
        
        menuTableViewManager = TutorAccountMenuTableViewManager()
        content.menuTableView.dataSource = menuTableViewManager
        content.menuTableView.delegate = menuTableViewManager
        menuTableViewManager?.delegate = self
        
        viewModel.fillData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isMovingFromParent{
            viewModel.viewDidDisappear()
        }
        
    }
    
    //MARK: - Override methods

    override func onConfigureController() {
//        navigationItem.leftBarButtonItem = nil
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.handleCallButtonTapAction = viewModel.callTutor
        content.handleWhatsappTapAction = viewModel.whatsappTutor
        content.handleTelegramTapAction = viewModel.telegramTutor
    }

}

//MARK: - Extension

extension TutorAccountController: TutorAccountViewModelOutput {
    func customizeOutput(image: UIImage, rating: Double, tutorInfo: [TitleSubtitleViewModel]) {
        content.setTutorData(image: image, rating: rating)
        tutorInfoTableViewManager?.setTutorData(tutorInfo, tableView: content.tutorInfoTableView)
    }
}

extension TutorAccountController: TutorAccountMenuTableViewDelegate {
    func selectedMenuItem(_ menuItem: Menu) {
        viewModel.menuItemTapped(menuItem)
    }
}
