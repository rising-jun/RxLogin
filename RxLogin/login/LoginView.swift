//
//  LoginView.swift
//  RxLogin
//
//  Created by 김동준 on 2021/03/16.
//

import Foundation
import UIKit
import SnapKit

class LoginView: BaseView{
    
    lazy var emailLabel = UILabel()
    
    lazy var emailField = UITextField()
    lazy var availableLabel = UILabel()
    lazy var nextButton: UIButton = {
        let nextButton = UIButton(frame: .zero)
        nextButton.autoresizingMask = .flexibleHeight
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.backgroundColor = .gray
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("다음", for: .normal)
        return nextButton
    }()
    
    
    override func setup() {
        super.setup()
        backgroundColor = .white
        addSubViews(emailLabel, emailField, availableLabel, nextButton)
        
        emailLabel.text = "이메일"
        emailLabel.textColor = .black
        emailLabel.font = UIFont.boldSystemFont(ofSize: 16)
        emailLabel.fillViewtoSize()
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(64)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        emailField.addLeftPadding()
        emailField.textColor = .black
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.gray.cgColor
        emailField.layer.cornerRadius = 10
        emailField.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해주세요.",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(emailLabel.snp.bottom).offset(1)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.height.equalTo(40)
        }
        
        availableLabel.textColor = .red
        availableLabel.fillViewtoSize()
        availableLabel.font = UIFont.boldSystemFont(ofSize: 12)
        availableLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailField.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(35)
            make.width.equalTo(335)
            make.height.equalTo(10)
            
        }
        
        nextButton.snp.remakeConstraints { (make) in
            //make.width.equalTo(350 * view.frame.width / 375)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-64)
        }
    
    }
    
    
}
