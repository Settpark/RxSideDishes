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
    let storage: BanchanStorageType
    
    init(sceneCoordinator: SceneCoordinatorType, storage: BanchanStorageType) {
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
    
}
