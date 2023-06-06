
import UIKit

final class VideoInfoController: VMController<VideoInfoPresentable, VideoInfoViewModelInput> {
    
    //MARK: - Properties
    
    private var tableViewManager: VideoInfoTableViewManager?

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewManager = VideoInfoTableViewManager()
        
        content.tableView.dataSource = tableViewManager
        content.tableView.delegate = tableViewManager
        viewModel.getDataFromModel()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isMovingFromParent {
            viewModel.viewDidDisappear()

        }
        
    }

    //MARK: - Override methods
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.handleWatchVideoButtonTapAction = viewModel.watchVideo
        content.handleViewTutorButtonTapAction = viewModel.viewTutor
        
    }

}

//MARK: - extension

extension VideoInfoController: VideoInfoViewModelOutput {
    func customizeOutput(with data: [TitleSubtitleViewModel]) {
        tableViewManager?.setTableViewData(data, tableView: content.tableView)
    }
}
