//
//  APIServiceType.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/04.
//

import Foundation
import RxSwift

protocol APIServiceType {
    func fetchDataWithSession(usecase: BanchanUsecase, onComplete: @escaping (Result<Banchans, Error>) -> Void)
    
    func fetchDataWithRx(usecase: BanchanUsecase) -> Observable<[Banchan]>
    
    func createRequest(url: URL) -> URLRequest
    
    func decodeData<T: Decodable>(type: T.Type, data: Data) -> Result<T,Error>
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    
}
