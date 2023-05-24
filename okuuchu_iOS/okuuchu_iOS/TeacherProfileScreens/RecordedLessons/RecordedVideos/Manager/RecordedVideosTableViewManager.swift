
import UIKit

//MARK: - Protocols

protocol RecordedVideoTableViewDelegate: AnyObject{
    func tappedCell(at indexPath: IndexPath)
    func selectedCell(at indexPath: IndexPath)
//    func setTranslucentBackround()
}

//MARK: - Class

class RecordedVideoTableViewManager: NSObject {
    weak var delegate: RecordedVideoTableViewDelegate?
    private var videos: [TitleSubtitleViewModel] = []
    private var isSelectingMode: Bool = false
    
    func setTableViewData(_ videos: [TitleSubtitleViewModel], tableView: UITableView){
        self.videos = videos
        tableView.reloadData()
    }
}


//MARK: - Extension
extension RecordedVideoTableViewManager: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = videos[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleSubtitleCell.self), for: indexPath) as? TitleSubtitleCell else {
            return TitleSubtitleCell()
        }
        
        cell.configureCell(with: video)
        
        if isSelectingMode {
            let emptyCheckmarkIcon = Asset.emptyCheckMarkIcon.image
            let checkmarkView = UIImageView(image: emptyCheckmarkIcon)
            checkmarkView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            
            cell.accessoryView = checkmarkView
        } else {
            cell.accessoryView = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSelectingMode{
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            let checkmarkView = UIImageView()
            checkmarkView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)

            let checkmarkIcon = Asset.checkmark.image
            let emptyCheckmarkIcon = Asset.emptyCheckMarkIcon.image

            guard let accessoryView = cell.accessoryView as? UIImageView  else { return }
            if accessoryView.image == emptyCheckmarkIcon {
                checkmarkView.image = checkmarkIcon
            } else {
                checkmarkView.image = emptyCheckmarkIcon
            }
            cell.accessoryView = checkmarkView
            
            delegate?.selectedCell(at: indexPath)
            
        } else {
            delegate?.tappedCell(at: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)

        
    }
}

//MARK: - Extension

extension RecordedVideoTableViewManager{
    func toggleSelectingMode(of tableView: UITableView){
        if isSelectingMode{
            isSelectingMode = false
        } else {
            isSelectingMode = true
        }
        
        tableView.reloadData()
    }
//    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
//        if gestureRecognizer.state == .began{
//            guard let cell = gestureRecognizer.view as? UITableViewCell else { return }
//
//            let pullDownView = PullDownOverlayView(frame: CGRect(x: 0, y: 0, width: cell.bounds.width / 2, height: cell.bounds.height / 2))
//
//            cell.addSubview(pullDownView)
//            delegate?.setTranslucentBackround()
//        }
//    }
}
