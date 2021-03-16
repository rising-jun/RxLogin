//
//  ViewController.swift
//  RxLogin
//
//  Created by 김동준 on 2021/03/16.
//

import UIKit
import RxSwift

class LoginViewController: BaseViewController {
    
    lazy var loginView = LoginView(frame: view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view = loginView
        
    }

}

