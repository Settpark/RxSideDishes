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
    
    private var banchans: [BanchanSection] = [] //dictionary로 개선해보자!? 배열을 미리 만들어 놓자?
    
    private lazy var stores = PublishSubject<[BanchanSection]>()
    private var apiEvent = PublishSubject<ApiServiceUseCase>()
    
    private var apiService: APIServiceType
    
    init(apiService: APIServiceType) {
        self.apiService = apiService
    }
    
    @discardableResult
    func banchanList() -> Observable<[BanchanSection]> {
        fetchAllListMainPage()
        return stores.asObservable()
    }
    
    @discardableResult
    func orderBanchan() -> Observable<Banchan> {
        return Observable.just(Banchan())
    }
    
    func fetchDetailPage(hash: String) {
        
    }
    
    func fetchAllListMainPage() {
        for i in 0..<ApiServiceUseCase.allCases.count { //for문이 아닌 이벤트로 전달할 수 있을까??
            apiService.fetchDataWithRx(api: ApiServiceUseCase.allCases[i].rawValue)
                .subscribe({ [weak self] emmiter in
                    switch emmiter {
                    case .next(let data):
                        let temp = BanchanSection.init(sectionitem: BanchanSection.getSctionType(i), items: data)
                        self?.banchans.append(temp)
                        self?.stores.onNext(self!.banchans) //순서 상관없이
                    case .error(let error):
                        print(error)
                    case .completed:
                        break
                    }
                })
        }
    }
}
