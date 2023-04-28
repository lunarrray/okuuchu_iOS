
import Foundation

enum Section {
    case imageSection(imageData: CellData)
    case titleTextViewSection(data: [CellData])
    case buttonsSection
    
    var numberOfItems: Int {
        switch self{
        case .imageSection: return 1
        case .titleTextViewSection(let data): return data.count
        case .buttonsSection: return 1
        }
    }
}
