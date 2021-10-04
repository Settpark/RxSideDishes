//
//  APIService.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/07/29.
//

import Foundation
import Alamofire
import RxSwift

enum BanchanUsecase: String, CaseIterable {
    case main = "main"
    case soup = "soup"
    case side = "side"
}

class APIService: APIServiceType {  //너는 왜 클래스니? //create Request //decoding //apimaker 가지고 있고
    //apimaker의 함수를 통해서 url.초기화
    var urlSessionManager: URLSessionProtocol
    var apiMaker: APIMakerType
    
    init(urlSessionManager: URLSessionProtocol, apiMaker: APIMakerType) {
        self.urlSessionManager = urlSessionManager
        self.apiMaker = apiMaker
    }
    
    func fetchDataRx(request: URLRequest) -> Observable<Data> {
        return URLSession.shared.rx.data(request: request)
    }
    
    func requestDataWithRx<T: Decodable>(request: URLRequest, type: T.Type) -> Observable<Result<T,Error>> {
        return fetchDataRx(request: request)
            .map { [unowned self] data in
                return self.decodedData(type: type, data: data)
            }
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
    
    func decodedData<T: Decodable>(type: T.Type, data: Data) -> Result<T,Error> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return .success(try decoder.decode(T.self, from: data))
        } catch {
            return .failure(error)
        }
    }
    
    func getfetchedImage(url: String, onComplete: @escaping (Result<UIImage, Error>) -> Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let err = error {
                    onComplete(.failure(err))
                }
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data: data) {
                        onComplete(.success(image))
                    }
                }
            }.resume()
        }
    }
}
