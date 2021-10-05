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
    
    private var apiService: APIServiceType
    private var imageManager: ImageCacheManager
    
    init(apiService: APIServiceType) {
        self.disposeBag = DisposeBag()
        self.apiService = apiService
        self.imageManager = ImageCacheManager(apiservice: apiService)
    }
    
    @discardableResult
    func banchanList(path: MainpageUsecase) -> Observable<[Banchan]> { //여기서 usecase만 전달 //apiService에선 주입받은 apimaker를 바탕으로 동작하도록
        let url = apiService.createVaildURL(string: path.rawValue)
        return apiService.requestDataWithRx(url: url, type: Banchans.self)
            .flatMap { self.toEntity(DTO: $0.body) }
    }
    
    func toEntity(DTO: [BanchanDTO]) -> Observable<[Banchan]> {
        let temp = DTO.map{ (DTO: Observable<BanchanDTO>.just($0), image: imageManager.getCachedImage(url: $0.imageURL)) }
        return Observable.from(temp)
            .flatMap {
                Observable.combineLatest($0, $1) { dto, image -> Banchan in
                    return Banchan.init(hash: dto.detailHash, image: image, alt: dto.alt, deliveryType: dto.deliveryType, title: dto.title, description: dto.description, nPrice: dto.nPrice, sPrice: dto.sPrice, badge: dto.badge)
                }.buffer(timeSpan: .never, count: DTO.count, scheduler: MainScheduler.instance)
            }
//                    Banchan.init(hash: data.detailHash, image: image, alt: data.alt, deliveryType: data.deliveryType, title: data.title, description: data.description, nPrice: data.nPrice, sPrice: data.sPrice, badge: data.badge)
//                }.buffer(timeSpan: .never, count: DTO.count, scheduler: MainScheduler.instance)
    }
    
    @discardableResult
    func orderBanchan() -> Observable<BanchanDTO> {
        return Observable.just(BanchanDTO())
    }
}
