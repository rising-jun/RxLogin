//
//  ViewController.swift
//  RxLogin
//
//  Created by 김동준 on 2021/03/16.
//

import UIKit
import RxSwift
import RxGesture
import RxViewController

class LoginViewController: BaseViewController {
    
    lazy var loginView = LoginView(frame: view.frame)
    private var disposeBag = DisposeBag()
    private var viewModel = LoginViewModel()
    private lazy var input = LoginViewModel
        .Input(keyboardAddObserve: rx.viewWillAppear
                .asSignal()
                .map{_ in Void()}
                .asObservable(),
               endEditing: loginView.rx
                .tapGesture()
                .map{_ in}
                .asObservable(),
               emailTouched: loginView.nextButton.rx
                .tap
                .map{self.loginView.emailField.text!}
                .asObservable(),
               checkValidEmail: loginView.emailField.rx
                .text
                .orEmpty
                .distinctUntilChanged()
                .debounce(.seconds(Int(1)), scheduler: MainScheduler.instance)
                .map{String($0)}
                .asObservable())
        
    private lazy var output = viewModel.transform(input: input)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view = loginView
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        output.keyboardObserveSet?.drive{ [weak self] _ in
            NotificationCenter.default.addObserver(self!, selector: #selector(self?.keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self!, selector: #selector(self?.keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        }.disposed(by: disposeBag)
        
        output.endEditingKeyboard?.drive{ [weak self] _ in
            self?.loginView.emailField.endEditing(true)
        }.disposed(by: disposeBag)
        
        output.isValidEmail?.drive{ [weak self] available in
            switch available{
                case .empty:
                    self?.loginView.emptyTextUI(textFiled: (self?.loginView.emailField)!,
                                                      noticeLabel: (self?.loginView.availableLabel)!,
                                                      button: (self?.loginView.nextButton)!)
                    break
                    
                case .usable:
                    self?.loginView.availableUI(textFiled: (self?.loginView.emailField)!,
                                                      noticeLabel: (self?.loginView.availableLabel)!,
                                                      button: (self?.loginView.nextButton)!)
                    break
            
                case .unusable:
                    self?.loginView.unavailableUI(textFiled: (self?.loginView.emailField)!,
                                                        noticeLabel: (self?.loginView.availableLabel)!,
                                                        button: (self?.loginView.nextButton)!)
                    break
            }
        }.disposed(by: disposeBag)
        
    }

    @objc
    func keyboardWillAppear(noti: Notification){
        UIView.animate(withDuration: 3) { [weak self] in
            guard let self = self else { return }
            self.loginView.nextButton.snp.updateConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-346)
            }
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc
    func keyboardWillDisappear(noti: Notification){
        UIView.animate(withDuration: 3) { [weak self] in
            guard let self = self else { return }
            self.loginView.nextButton.snp.updateConstraints { (make) in
                make.height.equalTo(40)
                make.left.equalToSuperview().offset(10 * self.view.frame.width / 375)
                make.right.equalToSuperview().offset(-10 * self.view.frame.width / 375)
                make.bottom.equalToSuperview().offset((-20 * self.view.frame.height / 812) - 44)
            }
            self.view.layoutIfNeeded()
        }
    }
    
}
