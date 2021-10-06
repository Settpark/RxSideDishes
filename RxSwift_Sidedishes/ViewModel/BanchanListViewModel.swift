
//  BanchanListViewModel.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/07/29.
//

import Foundation
import RxSwift

class BanchanListViewModel: CommonViewModel {
    
    var banchanList: Observable<[BanchanSection]> { //상당히 상황에 고정적인 코드 테스트하기 나쁘다.
        let mainDish = self.useCase.banchan(currentUsecase: .main)
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
}
