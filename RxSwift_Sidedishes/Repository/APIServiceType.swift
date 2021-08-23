//
//  APIServiceType.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/04.
//

import Foundation
import RxSwift

protocol APIServiceType {
    func fetchDataWithSession(apiMaker: APIMaker, onComplete: @escaping (Result<Banchans, Error>) -> Void)
    
    func fetchDataWithRx(apiMaker: APIMaker) -> Observable<[Banchan]>
}
