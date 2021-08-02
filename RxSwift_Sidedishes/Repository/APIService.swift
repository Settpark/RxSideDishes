//
//  APIService.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/07/29.
//

import Foundation
import Alamofire

let mainURL: String = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan"

class APIService {
    static func fetchDataWithSession(API: String, onComplete: @escaping (Result<Banchans, Error>) -> Void) {
        guard let url = URL(string: mainURL + API) else {
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
    
    static func fetchDataWithAF(API: String, onComplete: @escaping (Result<Banchans, Error>) -> Void) {
        guard let url = URL(string: mainURL + API) else {
            return
        }
        
        AF.request(url, method: .get) { data in
            
        }
    }
}
