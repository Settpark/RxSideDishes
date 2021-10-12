//
//  APIServiceType.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/04.
//

import Foundation
import RxSwift

protocol APIServiceType {
    func requestDataWithRx<T: Decodable>(url: URL, type: T.Type) -> Observable<T>
    func createVaildURL(string: String) -> URL
    func createRequest(url: URL) -> URLRequest
    func getfetchedImage(url: String) -> Observable<UIImage>
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    
}
