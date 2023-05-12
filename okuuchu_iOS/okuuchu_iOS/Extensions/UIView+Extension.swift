
import UIKit

public extension UIView{
    func addSubviews(_ views: UIView...){
        views.forEach{ addSubview($0) }
    }
    
    func addShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 4
    }
}
