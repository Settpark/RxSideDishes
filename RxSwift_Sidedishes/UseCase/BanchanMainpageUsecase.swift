//
//  File.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/10/05.
//

import RxSwift

struct BanchanMainpageUsecase: CommonUsecase {
    var repo: BanchanRepositoryType
    var currentUsecase: MainpageUsecase
    
    init(repository: BanchanRepository) {
        self.repo = repository
        currentUsecase = .none
    }
    
    func banchan(currentUsecase: MainpageUsecase) -> Observable<[Banchan]> {
        return repo.banchanList(path: currentUsecase)
    }
}


enum MainpageUsecase: String, CaseIterable {
    case main
    case soup
    case side
    case none
}
