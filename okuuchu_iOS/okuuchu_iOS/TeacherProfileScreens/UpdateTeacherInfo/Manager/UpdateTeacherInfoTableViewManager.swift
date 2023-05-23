

import UIKit

protocol UpdateTeacherInfoTableViewDelegate: AnyObject {
    
}

final class UpdateTeacherInfoTableViewManager: NSObject {
    weak var delegate: UpdateTeacherInfoTableViewDelegate?
    private var dataSource: [Section] = []
    private var tableView: UITableView?
    
    func setTeacherData(_ dataSource: [Section], tableView: UITableView){
        self.dataSource.removeAll(keepingCapacity: true)
        self.dataSource = dataSource
        self.tableView = tableView
        tableView.reloadData()
    }
}

extension UpdateTeacherInfoTableViewManager: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = dataSource[indexPath.section]
        
        switch section {
        case .imageSection(let imageData):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImageCell.self), for: indexPath) as? ImageCell else { return ImageCell() }
            cell.configureCell(with: imageData)
            cell.activateCameraButton()
            
            cell.selectionStyle = .none
            return cell
            
        case .titleTextViewSection(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LabeledTextViewCell.self), for: indexPath) as? LabeledTextViewCell else { return LabeledTextViewCell() }
            cell.setTextViewDelegate(delegate: self)
            let cellData = data[indexPath.row]
            cell.configureCell(with: cellData)
            
            cell.selectionStyle = .none
            return cell
            
        case .buttonsSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PrimaryButtonCell.self), for: indexPath) as? PrimaryButtonCell else { return PrimaryButtonCell() }
            cell.selectionStyle = .none
            cell.setButtonTitle("Сохранить")
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

extension UpdateTeacherInfoTableViewManager: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        let point = textView.convert(textView.bounds.origin, to: tableView)
        let newHeight = size.height
        if let indexPath = tableView?.indexPathForRow(at: point) {
            let cell = tableView?.cellForRow(at: indexPath) as? LabeledTextViewCell
            cell?.setHeightConstraint(newConstraint: newHeight)
            tableView?.beginUpdates()
            tableView?.endUpdates()
            tableView?.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
}


