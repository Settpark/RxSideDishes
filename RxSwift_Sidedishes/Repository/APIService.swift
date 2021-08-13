//
//  APIService.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/07/29.
//

import Foundation
import Alamofire
import RxSwift

enum ApiServiceUseCase: String, CaseIterable {
    case main = "/main"
    case soup = "/soup"
    case side = "/side"
}

class APIService: APIServiceType { //너는 왜 클래스니?
//    private let mainURL: String = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan"
    
    private let apiMaker: APIMakerType
    
    init(apiMaker: APIMakerType) {
        self.apiMaker = apiMaker
    }
    
    func fetchDataWithSession(api: String, onComplete: @escaping (Result<Banchans, Error>) -> Void) {
        guard let url = apiMaker.components.url else {
            return
        }
        let request = try! URLRequest.init(url: url, method: .get)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let localerr = error {
                onComplete(.failure(localerr))
                return
            }
            else {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try! decoder.decode(Banchans.self, from: data!)
                onComplete(.success(result))
            }
        }.resume()
    }
    
    func fetchDataWithAF(API: String, onComplete: @escaping (Result<Banchans, Error>) -> Void) {
        guard let url = apiMaker.components.url else {
            return
        }
        
        AF.request(url, method: .get) { data in
            
        }
    }
    
    func fetchDataWithRx(api: String) -> Observable<[Banchan]> {
        return Observable.create { [weak self] emmiter in
            self?.fetchDataWithSession(api: api) { result in
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
}
