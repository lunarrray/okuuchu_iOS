
import UIKit

open class BaseCell<Model>: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        onConfigureView()
        onAddSubviews()
        onSetupConstraints()
        onSetupTargets()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onConfigureView(){ }
    func onAddSubviews() { }
    func onSetupConstraints() { }
    func onSetupTargets() { }
    func configureCell(with model: Model) { }

}
