//
//  BanchanListViewModel.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/07/29.
//

import Foundation
import RxSwift

class BanchanListViewModel: CommonViewModel {
    
    var banchanList: Observable<[BanchanSection]> {
        let banchanList = PublishSubject<[BanchanSection]>()
        var banchanSection = [BanchanUsecase:BanchanSection].init(minimumCapacity: BanchanUsecase.allCases.count)
        
        Observable.from(BanchanUsecase.allCases)
            .subscribe { [weak self] mycase in
                self?.storage.banchanList(usecase: mycase)
                    .subscribe { emitter in
                        switch emitter {
                        case .next(let data):
                            banchanSection[mycase] = BanchanSection.init(sectionitem: .main, items: data)
                            guard let main = banchanSection[.main], let soup = banchanSection[.soup], let side = banchanSection[.side] else {
                                return
                            }
                            let temp: [BanchanSection] = [main, soup, side]
                            banchanList.onNext(temp)
                        case .error(_):
                            break
                        case .completed:
                            break
                        }
                    }.disposed(by: self!.rx.disposeBag)
            }.disposed(by: rx.disposeBag)
        return banchanList
    }
}
