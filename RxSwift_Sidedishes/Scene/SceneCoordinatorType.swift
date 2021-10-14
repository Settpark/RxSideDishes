//
//  SceneCoordinatorType.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/03.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult
    func close(animated: Bool) -> Completable
}
