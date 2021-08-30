//
//  APIMakeType.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/13.
//

import Foundation

protocol APIMakerType {
    var path: String { get set }
    var components: URLComponents { get }
    func createRequest(url: URL) -> URLRequest
    func decodeData<T: Decodable>(type: T.Type, data: Data) -> Result<T,Error>
}
