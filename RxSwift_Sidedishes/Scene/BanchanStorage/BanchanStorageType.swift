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
    func banchanList(usecase: BanchanUsecase) -> Observable<[Banchan]>
    
    @discardableResult
    func orderBanchan() -> Observable<Banchan>
}
