//
//  TransitionModel.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/02.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
