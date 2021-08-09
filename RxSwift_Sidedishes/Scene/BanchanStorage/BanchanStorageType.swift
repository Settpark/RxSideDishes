//
//  BanChanStorageType.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/02.
//

import Foundation
import RxSwift

protocol BanchanStorageType {    
    @discardableResult
    func banchanList() -> Observable<[BanchanSection]>
    
    @discardableResult
    func orderBanchan() -> Observable<Banchan>
}
