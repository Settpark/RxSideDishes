//
//  BanChanStorage.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/02.
//

import Foundation
import RxSwift

class BanchanStorage: BanchanStorageType {
    
    private let disposeBag: DisposeBag
    
    private var stores: PublishSubject<[Banchan]>
    private var apiEvent = PublishSubject<BanchanUsecase>()
    
    private var apiService: APIServiceType
    
    init(apiService: APIServiceType) {
        self.disposeBag = DisposeBag()
        self.apiService = apiService
        self.stores = PublishSubject<[Banchan]>()
    }
    
    @discardableResult
    func banchanList(usecase: BanchanUsecase) -> Observable<[Banchan]> {
            apiService.fetchDataWithRx(apiMaker: APIMaker.init(path: usecase))
                .subscribe(self.stores)
                .disposed(by: disposeBag)
        return stores
    }
    
    @discardableResult
    func orderBanchan() -> Observable<Banchan> {
        return Observable.just(Banchan())
    }
    
    func fetchDetailPage(hash: String) {
        
    }
}
