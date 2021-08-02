//
//  BanChanStorage.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/02.
//

import Foundation
import RxSwift

class BanchanStorage: BanchanStorageType {
    private var list = [
        Banchan.empty,
        Banchan.empty
    ]
    
    private lazy var store = BehaviorSubject<[Banchan]>(value: list)
    
    @discardableResult
    func banchanList() -> Observable<[Banchan]> {
        return store
    }
    
    @discardableResult
    func orderBanchan() -> Observable<Banchan> {
        let banchanempty = Banchan.empty
        return Observable.just(banchanempty)
    }
    
    
}
