//
//  CommonViewModel.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/03.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel: NSObject {
    let sceneCoordinator: SceneCoordinatorType
    var delegate: AlertController?
    let useCase: CommonUsecase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: CommonUsecase) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        self.delegate = nil
    }
}
