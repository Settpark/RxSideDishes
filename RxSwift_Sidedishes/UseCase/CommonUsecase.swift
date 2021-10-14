//
//  CommonUsecase.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/10/05.
//

import RxSwift

protocol CommonUsecase {
    var repo: BanchanRepositoryType { get }
    var currentUsecase: MainpageUsecase { get }
    
    init(repository: BanchanRepository)
    
    func banchan(currentUsecase: MainpageUsecase) -> Observable<[Banchan]>
}
