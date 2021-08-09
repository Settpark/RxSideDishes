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
    
    private var banchans: [BanchanSection] = []
    
    private lazy var stores = PublishRelay<[BanchanSection]>()
    private var apiService: APIServiceType
    
    init(apiService: APIServiceType) {
        self.apiService = apiService
        fetchAllListMainPage()
    }
    
    @discardableResult
    func banchanList() -> Observable<[BanchanSection]> {
        return stores.asObservable()
    }
    
    @discardableResult
    func orderBanchan() -> Observable<Banchan> {
        return Observable.just(Banchan())
    }
    
    func fetchAllListMainPage() {
        let apiList = [ApiServiceUseCase.main, ApiServiceUseCase.soup, ApiServiceUseCase.side]
        for i in 0..<apiList.count {
            let _ = apiService.fetchDataWithRx(api: apiList[i].rawValue)
                .subscribe({ [weak self] emmiter in
                    switch emmiter {
                    case .next(let data):
                        let temp = BanchanSection.init(sectionitem: BanchanSection.getSctionType(i), items: data)
                        self?.banchans.append(temp)
                        self?.stores.accept(self!.banchans)
                    case .error(let error):
                        print(error)
                    case .completed:
                        break
                    }
                })
        }
    }
}
