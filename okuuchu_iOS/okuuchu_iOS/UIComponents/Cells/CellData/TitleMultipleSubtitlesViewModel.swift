

import Foundation

class TitleMultipleSubtitlesViewModel {
    let title: String?
    private(set) var subtitles: [String]?
    private(set) var onCellUpdate: (() -> Void)?
    
    init(title: String? = nil, subtitles: [String]? = nil, onCellUpdate: (() -> Void)? = nil) {
        self.title = title
        self.subtitles = subtitles
        self.onCellUpdate = onCellUpdate
    }
    
    func numberOfItems() -> Int {
        guard let subtitles = subtitles else { return 0}
        return subtitles.count
    }
    
    func update(_ subtitles: [String]){
        self.subtitles = subtitles
        
        if let onCellUpdate = onCellUpdate {
            onCellUpdate()
        }
    }
}
