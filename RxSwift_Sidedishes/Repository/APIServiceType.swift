//
//  APIServiceType.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/04.
//

import Foundation
import RxSwift

protocol APIServiceType {
    func fetchDataWithSession(api: String, onComplete: @escaping (Result<Banchans, Error>) -> Void)
    
    func fetchDataWithAF(API: String, onComplete: @escaping (Result<Banchans, Error>) -> Void)
    
    func fetchDataWithRx(api: String) -> Observable<[Banchan]>
}
