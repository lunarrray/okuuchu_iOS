

import UIKit

class ScheduleController: VMController<SchedulePresentable, ScheduleViewModelInput> {
    
    //MARK: - Properties
    
    private var tableViewManager: ScheduleTableViewManager?
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewManager = ScheduleTableViewManager()
        content.tableView.dataSource = tableViewManager
        content.tableView.delegate = tableViewManager
        
        tableViewManager?.delegate = self
        
        viewModel.getScheduleDataFromModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.viewDidDisappear()
    }
    
    //MARK: - Methos
    
    override func onConfigureController() {
        navigationItem.rightBarButtonItem = content.navigation.deleteButton
        navigationItem.title = "Бош убакыт"
        navigationItem.largeTitleDisplayMode = .never

    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.handleSegmentedControlValueChanged = viewModel.toggleTableView(segmentedControlIndex:)
        content.handleDeleteButtonTapAction = viewModel.deleteButtonTapped
        content.handleAddButtonTapAction = showAlert
        content.handleSaveButtonAction = viewModel.saveButtonTapped
    }
}

//MARK: - Extension

extension ScheduleController: ScheduleViewModelOutput{
    func customizeOutput(with scheduleData: [String], selectedIndexes: Set<Int>, isEditingMode: Bool) {
        
        if !isEditingMode {
            content.nonEditableView()
        }
        var currentScheduleData = [TitleSubtitleViewModel]()
        
        for item in scheduleData {
            let cellData = TitleSubtitleViewModel(subtitle: item)
            currentScheduleData.append(cellData)
        }
        
        tableViewManager?.setData(currentScheduleData, selectedIndexes: selectedIndexes, tableView: content.tableView, isEditingMode: isEditingMode)
    }
}

extension ScheduleController: ScheduleTableViewDelegate {
    func selectedCell(at indexPath: IndexPath) {
        viewModel.addSelectedItemToSet(at: indexPath)
    }
    
    func deselectedCell(at indexPath: IndexPath) {
        viewModel.removeSelectedItemFromSet(at: indexPath)
    }

}

extension ScheduleController {
    private func showAlert(){
        let alertController = UIAlertController(title: "Бош убакытты кошуңуз", message: "Бош убакыттын башталышын жана аяктоочу убактысын жазыңыз", preferredStyle: .alert)
        var startTextField = UITextField()
        
        alertController.addTextField { textField in
            textField.placeholder = "Баштоо убактысы"
            textField.keyboardType = .decimalPad
            textField.delegate = self
            startTextField = textField
        }
        
        var endTextField = UITextField()
        alertController.addTextField { textField in
            textField.delegate = self
            textField.placeholder = "Бүтүү убактысы"
            textField.keyboardType = .decimalPad
            endTextField = textField
        }
                
        let addAction = UIAlertAction(title: "Кошуу", style: .default) { [weak self] _ in
            let firstValue = startTextField.text ?? ""
            let secondValue = endTextField.text ?? ""
            
            if firstValue != "" && secondValue != ""{
                self?.viewModel.processInput(firstValue: firstValue, secondValue: secondValue)
            }
        }

        let cancelAction = UIAlertAction(title: "Баш тартуу ", style: .cancel, handler: nil)

        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ScheduleController: UITextFieldDelegate {
    
}
