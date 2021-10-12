//
//  BanChanStorageType.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/02.
//

import Foundation
import RxSwift

protocol BanchanRepositoryType {    
    @discardableResult
    func banchanList(path: MainpageUsecase) -> Observable<[Banchan]>
    
    @discardableResult
    func orderBanchan() -> Observable<BanchanDTO>
}
