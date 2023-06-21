
import UIKit

class ReviewsController: VMController<ReviewsPresentable, ReviewsViewModelInput> {
    
    //MARK: - Ppoperties
    
    var tableViewManager: ReviewsTableViewManager?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewManager = ReviewsTableViewManager()
        
        content.tableView.dataSource = tableViewManager
        content.tableView.delegate = tableViewManager
        
        viewModel.getData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.viewDidDisappear()
    }
    
    //MARK: - Override methods
    
    override func onConfigureController() {
        navigationItem.title = "Сын-пикирлер"
        navigationItem.rightBarButtonItem = content.navigation.addButton
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.handleAddButtonTapAction = viewModel.addReview

    }

}

//MARK: - Extension

extension ReviewsController: ReviewsViewModelOutput {
    func customizeOutput(with data: [ReviewData], rating: Double, isAddingReviewMode: Bool) {
        content.setReviewData(rating: rating, isAddingReviewMode: isAddingReviewMode)
        tableViewManager?.setTableViewData(reviews: data, tableView: content.tableView)
    }
    
    
}
