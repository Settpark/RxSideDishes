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
        apiService.fetchDataWithRx(usecase: usecase)
            .map {$0.body}
            .subscribe(onNext: { [weak self] data in
                var banchans = Array<Banchan>(repeating: Banchan.empty, count: data.count)
                for i in 0..<data.count {
                    let temp = data[i]
                    self?.imageManager.getCachedImage(url: data[i].image, onComplete: { result in
                        switch result {
                        case .success(let image):
                            banchans[i] = Banchan.init(hash: temp.detailHash,
                                                       image: image,
                                                       alt: temp.alt,
                                                       deliveryType: temp.deliveryType,
                                                       title: temp.title,
                                                       description: temp.description,
                                                       nPrice: temp.nPrice,
                                                       sPrice: temp.sPrice,
                                                       badge: temp.badge)
                            self?.eventer.onNext(banchans)
                        case .failure(let err):
                            print(err)
                        }
                    })
                }
            }).disposed(by: disposeBag)
        return eventer
    }
    
    @discardableResult
    func orderBanchan() -> Observable<BanchanDTO> {
        return Observable.just(BanchanDTO())
    }
}
