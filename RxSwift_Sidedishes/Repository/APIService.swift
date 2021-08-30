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
    
    func fetchDataWithSession(usecase: BanchanUsecase, onComplete: @escaping (Result<Banchans, Error>) -> Void) {
        let validURL = apiMaker.createValidURL(path: usecase)
        
        let request = self.createRequest(url: validURL)
        
        self.urlSessionManager.dataTask(with: request) { [weak self] data, response, error in
            if let localerr = error {
                onComplete(.failure(localerr))
                return
            }
            else {
                guard let validData = data else {
                    return
                }
                let result = self?.decodeData(type: Banchans.self, data: validData)
                switch result {
                case .success(let data):
                    onComplete(.success(data))
                case .failure(let error):
                    onComplete(.failure(error))
                case .none:
                    break
                }
            }
        }.resume()
    }
    
    func fetchDataWithRx(usecase: BanchanUsecase) -> Observable<[Banchan]> {
        return Observable.create { [weak self] emmiter in
            self?.fetchDataWithSession(usecase: usecase) { result in
                switch result {
                case .success(let data):
                    emmiter.onNext(data.body)
                    emmiter.onCompleted()
                case .failure(let error):
                    emmiter.onError(error)
                }
            }
            return Disposables.create()
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
    
    func decodeData<T: Decodable>(type: T.Type, data: Data) -> Result<T,Error> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return Result.success(try decoder.decode(T.self, from: data))
        } catch {
            return Result.failure(error)
        }
    }
}
