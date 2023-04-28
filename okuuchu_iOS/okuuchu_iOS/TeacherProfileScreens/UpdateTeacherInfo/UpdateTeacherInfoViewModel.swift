

import Foundation


protocol UpdateTeacherInfoViewModelInput {
    var coordinator: UpdateTeacherInfoCoordinator? { get set }
    var output: UpdateTeacherInfoViewModelOutput? { get set }
    
    func getTeacherDataFromModel()
}


protocol UpdateTeacherInfoViewModelOutput: AnyObject{
    func customizeOutput(with dataSource: [Section])
}

final class UpdateTeacherInfoViewModel {
    var coordinator: UpdateTeacherInfoCoordinator?
    weak var output: UpdateTeacherInfoViewModelOutput?{
        didSet {
            output?.customizeOutput(with: dataSource)
        }
    }
    
    private var teacherData: [CellData] = []{
        didSet {
            self.dataSource.removeAll(keepingCapacity: true)
            self.dataSource = createDataSource()
        }
    }
    private var dataSource: [Section] = []
}

extension UpdateTeacherInfoViewModel: UpdateTeacherInfoViewModelInput {
    func getTeacherDataFromModel() {
        //asking data from model
        teacherData = [
            
            CellData(title: "Имя и фамилия", subtitle: "Азима Асанова"),
            CellData(title: "Немного о себе", subtitle: "Lörem ipsum klimatmat fibid tisos, supöning retopi. Geodögisk ont vifilig. Föder vitigt, gyförat. Egol seminas köns gepåktig timypp. "),
            CellData(title: "Образование", subtitle: "Lörem ipsum klimatmat fibid tisos, supöning retopi. Geodögisk "),
            CellData(title: "Дата рождения", subtitle: "12.02.2000"),
            CellData(title: "Номер для связи", subtitle: "+996 707 70 70 70"),
            CellData(title: "Whatsapp", subtitle: "+996 990 506 014"),
            CellData(title: "Telegram", subtitle: "+996 990 506 014"),
            CellData(title: "Опыт репетиторства", subtitle: "4 года"),
            CellData(title: "Местоположение", subtitle: "Бишкек"),
            CellData(title: "Языки преподавания", subtitle: "Русский, Кыргызский", subTextType: .selectingSeveral),
            CellData(title: "Предметы", subtitle: "Математика, Программирование", subTextType: .selectingSeveral),
        ]
        output?.customizeOutput(with: dataSource)
    }
}

extension UpdateTeacherInfoViewModel {
    private func createDataSource() -> [Section] {
        var sections = [Section]()
        sections.append(.imageSection(imageData: CellData(image: Asset.avatarImg.image, subTextType: .image)))
        let primaryTeacherData = [
        CellData(title: "Имя и фамилия", subtitle: "Азима Асанова"),
            CellData(title: "Немного о себе", subtitle: "Lörem ipsum klimatmat fibid tisos, supöning retopi. Geodögisk ont vifilig. Föder vitigt, gyförat. Egol seminas köns gepåktig timypp. "),
            CellData(title: "Образование", subtitle: "Lörem ipsum klimatmat fibid tisos, supöning retopi. Geodögisk "),
        CellData(title: "Дата рождения", subtitle: "12.02.2000", subTextType: .date),
        CellData(title: "Номер для связи", subtitle: "+996 707 70 70 70", subTextType: .phoneNumber),
        CellData(title: "Whatsapp", subtitle: "+996 990 506 014", subTextType: .phoneNumber),
        CellData(title: "Telegram", subtitle: "+996 990 506 014", subTextType: .phoneNumber),
            CellData(title: "Опыт репетиторства", subtitle: "4 года"),
            CellData(title: "Местоположение", subtitle: "Бишкек"),
            CellData(title: "Языки преподавания", subtitle: "Русский, Кыргызский", subTextType: .selectingSeveral),
            CellData(title: "Предметы", subtitle: "Математика, Программирование", subTextType: .selectingSeveral),
        ]
        sections.append(.titleTextViewSection(data: primaryTeacherData))
        sections.append(.buttonsSection)
        
        return sections
    }
}
