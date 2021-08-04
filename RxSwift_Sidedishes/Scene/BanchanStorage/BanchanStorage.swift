//
//  BanChanStorage.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/02.
//

import Foundation
import RxSwift
import NSObject_Rx
import RxCocoa

class BanchanStorage: BanchanStorageType {
    
    private var list: [Banchan] = []
    private lazy var store = BehaviorSubject<[Banchan]>(value: list)
    private var apiService: APIServiceType
    
    init(apiService: APIServiceType) {
        self.apiService = apiService
        apiService.fetchDataWithRx(api: "/main")
            .subscribe({ [weak self] emmiter in
                switch emmiter {
                case .next(let data):
                    self?.store.onNext(data)
                case .error(let error):
                    print(error)
                case .completed:
                    break
                }
            })
    }
    
    @discardableResult
    func banchanList() -> Observable<[Banchan]> {
        return store.asObservable()
    }
    
    @discardableResult
    func orderBanchan() -> Observable<Banchan> {
        let banchanempty = Banchan.empty
        return Observable.just(banchanempty)
    }
    
    
}
