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
    func banchanList(usecase: BanchanUsecase) -> Observable<[Banchan]> { //여기서 usecase만 전달 //apiService에선 주입받은 apimaker를 바탕으로 동작하도록
        return apiService.fetchDataWithRx(usecase: usecase)
    }
    
    @discardableResult
    func orderBanchan() -> Observable<Banchan> {
        return Observable.just(Banchan())
    }
}
