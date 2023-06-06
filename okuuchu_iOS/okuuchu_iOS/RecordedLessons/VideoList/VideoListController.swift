
import UIKit

class VideoListController: VMController<VideoListPresentable, VideoListViewModelInput>{
    
    //MARK: - Properties
    
    private var tableViewManager: VideoListTableViewManager?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewManager = VideoListTableViewManager()
        content.tableView.dataSource = tableViewManager
        content.tableView.delegate = tableViewManager
        
        tableViewManager?.delegate = self
        viewModel.getRecordedVideosFromModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent{
            viewModel.viewDidDisappear()
        }
    }
    
    //MARK: - Override methods
    
    override func onConfigureController() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }

    override func onConfigureActions() {
        content.searchField.delegate = self
    }

}

//MARK: - Extension

extension VideoListController: VideoListViewModelOutput{
    func customizeOutput(with videos: [TitleSubtitleViewModel]) {
        tableViewManager?.setTableViewData(videos, tableView: content.tableView)
    }
}

extension VideoListController: VideoListTableViewDelegate{
    func tappedCell(at indexPath: IndexPath) {
        let index = indexPath.row
        viewModel.subjectItemTapped(at: index)
    }
}

extension VideoListController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            if text != ""{
                viewModel.performSearch(with: text)
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            viewModel.getRecordedVideosFromModel()
        }
    }
}

