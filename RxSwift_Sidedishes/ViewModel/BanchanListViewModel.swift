
//  BanchanListViewModel.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/07/29.
//

import Foundation
import RxSwift

class BanchanListViewModel: CommonViewModel {
    
    var delegate: AlertController?
    
    var banchanList: Observable<[BanchanSection]> { //상당히 상황에 고정적인 코드 테스트하기 나쁘다.
        let result = PublishSubject<[BanchanSection]>()
        let allList: [BanchanUsecase:PublishSubject<BanchanSection>] = [.main: PublishSubject<BanchanSection>(), .soup: PublishSubject<BanchanSection>(), .side: PublishSubject<BanchanSection>()]
        
        Observable.from(BanchanUsecase.allCases).subscribe() { [weak self] mycase in
            self?.storage.banchanList(usecase: mycase)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { data in
                    let banchan = BanchanSection.init(sectionitem: mycase, items: data)
                    allList[mycase]?.onNext(banchan)
                }, onError: { error in
                    self?.delegate?.showAlertController(error: error)
                }).disposed(by: self!.rx.disposeBag)
        }.disposed(by: rx.disposeBag)
        
        Observable.combineLatest(allList[.main]!, allList[.soup]!, allList[.side]!) { main, soup, side  -> [BanchanSection] in
            let combineResult = [main, soup ,side]
            return combineResult
        }.subscribe(onNext: { data in
            result.onNext(data)
        })
        .disposed(by: rx.disposeBag)
        
        return result
    }
}
