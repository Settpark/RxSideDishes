//
//  BanChanStorage.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/02.
//

import Foundation
import RxSwift

class BanchanRepository: BanchanRepositoryType {
    
    private let disposeBag: DisposeBag
    
    private var eventer = PublishSubject<[Banchan]>()
    private var apiService: APIServiceType
    private var imageManager: ImageCacheManager
    
    init(apiService: APIServiceType) {
        self.disposeBag = DisposeBag()
        self.apiService = apiService
        self.imageManager = ImageCacheManager(apiservice: apiService)
    }
    
    @discardableResult
    func banchanList(usecase: BanchanUsecase) -> Observable<[Banchan]> { //여기서 usecase만 전달 //apiService에선 주입받은 apimaker를 바탕으로 동작하도록
    }
    
    @discardableResult
    func orderBanchan() -> Observable<BanchanDTO> {
        return Observable.just(BanchanDTO())
    }
}
