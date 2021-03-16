//
//  BaseClass.swift
//  RxLogin
//
//  Created by 김동준 on 2021/03/16.
//

import Foundation
import UIKit

class BaseView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = .black
    }
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    public func setup() {
        
    }
    
    public func bind() {
        
    }
}

extension UIView {
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

extension UILabel{
    final func fillViewtoSize(){
        minimumScaleFactor = 0.1
        adjustsFontSizeToFitWidth = true
    }
}

extension UITextField{
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func reomoveErrorImg(){
        rightView = nil
    }
    
    func createBorder(){
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let errorImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        errorImg.image = UIImage(named: "error")
        errorImg.contentMode = .scaleAspectFit
        rightView.addSubview(errorImg)
        let rightPadding: CGFloat = 20 //--- change right padding
        rightView.frame = CGRect(x: 0, y: 0, width: errorImg.frame.size.width + rightPadding , height: errorImg.frame.size.height)
        self.rightView = rightView
        self.rightViewMode = .always
    }
}
