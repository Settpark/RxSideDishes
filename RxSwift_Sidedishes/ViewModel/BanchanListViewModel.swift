
//  BanchanListViewModel.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/07/29.
//

import Foundation
import RxSwift

class BanchanListViewModel: CommonViewModel {
    
    var banchanList: Observable<[BanchanSection]> { //상당히 상황에 고정적인 코드 테스트하기 나쁘다.
        let result = PublishSubject<[BanchanSection]>()
        
        return result
    }
}
