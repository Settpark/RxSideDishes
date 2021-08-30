//
//  BanChanDetailViewModel.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/12.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class BanChanDetailViewModel: CommonViewModel {
    lazy var popAction = CocoaAction { [unowned self] in
        return self.sceneCoordinator.close(animated: true).asObservable().map { _ in
        }
    }
    //action
}
