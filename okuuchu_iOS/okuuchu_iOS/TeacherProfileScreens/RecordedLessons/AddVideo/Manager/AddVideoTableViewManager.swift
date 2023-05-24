
import UIKit

//MARK: Protocol

protocol AddVideoTableViewDelegate: AnyObject{
    func updateCell(for indexPath: IndexPath, subtitle: String)
}

//MARK: - Class
class AddVideoTableViewManager: NSObject{
    weak var delegate: AddVideoTableViewDelegate?
    private var tableView: UITableView?
    private var data: [TitleSubtitleViewModel] = []
    
    func setTableViewData(_ data: [TitleSubtitleViewModel], tableView: UITableView){
        self.data = data
        self.tableView = tableView
        tableView.reloadData()
    }
}

//MARK: - Extension

extension AddVideoTableViewManager: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = data[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LabeledTextViewCell.self), for: indexPath) as? LabeledTextViewCell else {
            return LabeledTextViewCell()
        }
        cell.setTextViewDelegate(delegate: self)
        cell.configureCell(with: cellData)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

extension AddVideoTableViewManager: UITextViewDelegate {
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        guard let currentText = textView.text else { return false }
        let text = currentText + text
        
        let point = textView.convert(textView.bounds.origin, to: tableView)
        if let indexPath = tableView?.indexPathForRow(at: point) {
            delegate?.updateCell(for: indexPath, subtitle: text)
        }
        return true
    }
}
