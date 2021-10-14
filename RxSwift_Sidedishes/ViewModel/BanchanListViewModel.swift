
//  BanchanListViewModel.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/07/29.
//

import Foundation
import RxSwift

class BanchanListViewModel: CommonViewModel {
    
    let disposebag = DisposeBag()
    
    var banchanList: Observable<[BanchanSection]> {
        
        let mainDish = self.useCase.banchan(currentUsecase: .none)
        let soupDish = self.useCase.banchan(currentUsecase: .soup)
        let sideDish = self.useCase.banchan(currentUsecase: .side)
        
        return Observable.combineLatest(mainDish, soupDish, sideDish, resultSelector: { main, soup, side -> [BanchanSection] in
            let dishes = [
                BanchanSection(sectionitem: .main, items: main),
                BanchanSection(sectionitem: .side, items: soup),
                BanchanSection(sectionitem: .soup, items: side)
            ]
            return dishes
        })
    }
    
    func handlingError() {
        self.banchanList.subscribe { data in
            print("aa")
        } onError: { err in
            self.delegate?.showAlertController(error: err)
        }.disposed(by: disposebag)
    }
}
