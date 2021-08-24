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
    
    private var apiEvent = PublishSubject<BanchanUsecase>()
    private var apiService: APIServiceType
    
    init(apiService: APIServiceType) {
        self.disposeBag = DisposeBag()
        self.apiService = apiService
    }
    
    @discardableResult
    func banchanList(usecase: BanchanUsecase) -> Observable<[Banchan]> {
        return apiService.fetchDataWithRx(apiMaker: APIMaker.init(path: usecase))
    }
    
    @discardableResult
    func orderBanchan() -> Observable<Banchan> {
        return Observable.just(Banchan())
    }
    
    func fetchDetailPage(hash: String) {
        
    }
}
