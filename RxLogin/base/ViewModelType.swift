//
//  ViewModelType.swift
//  RxLogin
//
//  Created by 김동준 on 2021/03/16.
//

import Foundation

protocol ViewModelType: class {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
