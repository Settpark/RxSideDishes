//
//  APIService.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/07/29.
//

import Foundation
import Alamofire
import RxSwift
import UIKit

class APIService: APIServiceType {  //너는 왜 클래스니? //create Request //decoding //apimaker 가지고 있고
    //apimaker의 함수를 통해서 url.초기화
    private let urlSessionManager: URLSessionProtocol
    private let endPoint: EndpointManager
    
    init(urlSessionManager: URLSessionProtocol, endPoint: EndpointManager) {
        self.urlSessionManager = urlSessionManager
        self.endPoint = endPoint
    }
    
    func requestDataWithRx<T: Decodable>(url: URL, type: T.Type) -> Observable<T> {
        let request = createRequest(url: url)
        return URLSession.shared.rx.data(request: request)
            .flatMap { [unowned self] data in
                return self.decodedData(type: type, data: data)
            }
    }
    
    func createVaildURL(string: String) -> URL {
        return endPoint.createValidURL(path: string)
    }
    
    func createRequest(url: URL) -> URLRequest {
        var request: URLRequest = URLRequest.init(url: url)
        do {
            request = try URLRequest.init(url: url, method: .get)
        } catch {
            print(APIServiceError.wrongRequest)
        }
        return request
    }
    
    func decodedData<T: Decodable>(type: T.Type, data: Data) -> Observable<T> {
        return Observable.create { emitter in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                try emitter.onNext(decoder.decode(type, from: data))
            } catch {
                emitter.onError(APIServiceError.failedDecoding)
            }
            return Disposables.create()
        }
    }
    
    func getfetchedImage(url: String) -> Observable<UIImage> {
        let validURL = endPoint.createValidURL(path: url)
        let request = self.createRequest(url: validURL)
        return URLSession.shared.rx.data(request: request)
            .map { UIImage(data: $0) ?? UIImage() }
    }
}
