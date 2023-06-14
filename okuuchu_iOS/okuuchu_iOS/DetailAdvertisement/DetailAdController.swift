
import UIKit

final class DetailAdController: VMController<DetailAdPresentable, DetailAdViewModelInput> {
    
    //MARK: - Properties
    
    private var tableViewManager: DetailAdTableViewManager?
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewManager = DetailAdTableViewManager()
        
        content.tableView.dataSource = tableViewManager
        content.tableView.delegate = tableViewManager
        
        viewModel.prepareData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            viewModel.viewDidDisappear()
        }
    }

    
    //MARK: - Override methods

    override func onConfigureController() {
        navigationItem.rightBarButtonItem = content.navigation.saveButton
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.handleTutorButtonTapAction = viewModel.openTutorDetail
        content.handleCallButtonTapAction = viewModel.callTutor
        content.handleWhatsappTapAction = viewModel.whatsappTutor
        content.handleTelegramTapAction = viewModel.telegramTutor
    }
}

//MARK: - Extension

extension DetailAdController: DetailAdViewModelOutput {
    func customizeOutput(detailData: [TitleSubtitleViewModel], image: UIImage, priceText: String, titleText: String, tutorText: String, tutorImage: UIImage, descriptionText: String) {
        content.setContentData(image: image, priceText: priceText, titleText: titleText, tutorText: tutorText, tutorImage: tutorImage, descriptionText: descriptionText)
        tableViewManager?.setData(detailData, tableView: content.tableView)
    }
}
