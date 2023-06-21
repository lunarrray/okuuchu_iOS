
import UIKit

enum TeachingLanguage {
    case russian
    case turkish
    case kyrgyz
    case english
    
    var title: String {
        switch self {
        case .russian:
            return "Орусча"
        case .turkish:
            return "Түркчө"
        case .kyrgyz:
            return "Кыргызча"
        case .english:
            return "Англисче"
        }
    }
}

enum Lesson {
    case math
    case programming
    case chemistry
    case biology
    case english
    case russian
    case russianLiterature
    case german
    case physics
    case history
    case geography
    case geometry
    case kyrgyz
    case kyrgyzLiterature
    case turkish
    
    var title: String {
        switch self {
        case .math:
            return "Математика"
        case .programming:
            return "Программалоо"
        case .chemistry:
            return "Химия"
        case .biology:
            return "Биология"
        case .english:
            return "Английис тили"
        case .russian:
            return "Орус тили"
        case .russianLiterature:
            return "Орус адабияты"
        case .german:
            return "Немис тили"
        case .physics:
            return "Физика"
        case .history:
            return "Тарых"
        case .geography:
            return "География"
        case .geometry:
            return "Геометрия"
        case .kyrgyz:
            return "Кыргыз тили"
        case .kyrgyzLiterature:
            return "Кыргыз адабияты"
        case .turkish:
            return "Түрк тили"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .math:
            return Asset.math.image
        case .programming:
            return Asset.programming.image
        case .chemistry:
            return Asset.chemistry.image
        case .biology:
            return Asset.biology.image
        case .english:
            return Asset.english.image
        case .russian:
            return Asset.russian.image
        case .russianLiterature:
            return Asset.russianLiterature.image
        case .german:
            return Asset.german.image
        case .physics:
            return Asset.physics.image
        case .history:
            return Asset.history.image
        case .geography:
            return Asset.geography.image
        case .geometry:
            return Asset.geometry.image
        case .kyrgyz:
            return Asset.kyrgyz.image
        case .kyrgyzLiterature:
            return Asset.kyrgyzLiterature.image
        case .turkish:
            return Asset.turkish.image
        }
    }
}

enum TeachingType{
    case online
    case offline
    case group
    case individual
    
    var title: String {
        switch self {
        case .online:
            return "Онлайн"
        case .offline:
            return "Оффлайн"
        case .group:
            return "Группада"
        case .individual:
            return "Жекече"
        }
    }
}

enum Location {
    case chui
    case naryn
    case osh
    case jalalAbad
    case talas
    case batken
    case issykKul
    
    var title: String {
        switch self {
        case .chui:
            return "Чуй"
        case .naryn:
            return "Нарын"
        case .osh:
            return "Ош"
        case .jalalAbad:
            return "Жалал-Абад"
        case .talas:
            return "Талас"
        case .batken:
            return "Баткен"
        case .issykKul:
            return "Ысык-көл"
        }
    }
}

enum ActiveStatus {
    case active
    case inactive
}

