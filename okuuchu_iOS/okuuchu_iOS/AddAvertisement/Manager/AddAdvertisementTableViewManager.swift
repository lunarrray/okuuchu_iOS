
import UIKit

protocol AddAdvertisementTableViewDelegate: AnyObject {
    
}

final class AddAdvertisementTableViewManager: NSObject {
    weak var delegate: AddAdvertisementTableViewDelegate?
    private var advertisementData: [TitleSubtitleViewModel] = []
    private var tableView: UITableView?
    
    func setData(_ advertisementData: [TitleSubtitleViewModel], tableView: UITableView) {
        self.advertisementData = advertisementData
        self.tableView = tableView
        tableView.reloadData()
    }
}

extension AddAdvertisementTableViewManager: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return advertisementData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellData = advertisementData[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LabeledTextViewCell.self), for: indexPath) as? LabeledTextViewCell else { return LabeledTextViewCell() }
        cell.setTextViewDelegate(delegate: self)
        
        cell.configureCell(with: cellData)
        
        cell.selectionStyle = .none
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

extension AddAdvertisementTableViewManager: UITextViewDelegate {
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


