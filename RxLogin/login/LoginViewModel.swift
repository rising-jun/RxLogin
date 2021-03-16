//
//  LoginViewModel.swift
//  RxLogin
//
//  Created by 김동준 on 2021/03/16.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelType{
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let keyboardObserve = BehaviorRelay(value: 0)
        input.keyboardAddObserve?.subscribe{_ in
            keyboardObserve.accept(keyboardObserve.value + 1)
        }.disposed(by: disposeBag)
        
        let endEditingKeyboard = BehaviorRelay(value: 0)
        input.endEditing?.subscribe{ _ in
            endEditingKeyboard.accept(endEditingKeyboard.value)
        }.disposed(by: disposeBag)
        
        
        let vaildCheck = BehaviorRelay(value: TextInputState.empty)
        input.checkValidEmail?.subscribe{ (email) in
            var val = email.element
            if val == ""{
                vaildCheck.accept(.empty)
            }else{
                if self.isValidEmail(testStr: val!){
                    vaildCheck.accept(.usable)
                }else{
                    vaildCheck.accept(.unusable)
                }
            }
        }.disposed(by: disposeBag)
        
        
        return Output(
                      keyboardObserveSet: keyboardObserve.asDriver(),
                      endEditingKeyboard: endEditingKeyboard.asDriver(),
                      isValidEmail: vaildCheck.asDriver())
    }
    
    struct Input{
        var keyboardAddObserve: Observable<Void>?
        var endEditing: Observable<Void>?
        var loginTouched: Observable<Void>?
        
        var emailTouched: Observable<String>?
        var checkValidEmail: Observable<String>?
        
        
        var startTouched: Observable<Void>?
    }
    
    struct Output{
        //var moveScreen: Driver<ScreenStatus>?
        
        var keyboardObserveSet: Driver<Int>?
        var endEditingKeyboard: Driver<Int>?
        
        var isValidEmail: Driver<TextInputState>?
        
    }
    
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}
