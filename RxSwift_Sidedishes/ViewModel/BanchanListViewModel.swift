//
//  BanchanListViewModel.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/07/29.
//

import Foundation
import RxSwift
import RxCocoa

class BanchanListViewModel: CommonViewModel {
    var banchanList: Observable<[Banchan]> {
        return storage.banchanList()
    }
}
