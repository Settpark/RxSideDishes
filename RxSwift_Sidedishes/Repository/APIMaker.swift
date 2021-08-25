//
//  APIMaker.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/13.
//

import Foundation

struct APIMaker: APIMakerType {
    var path: String = "/develop/baminchan"
    var components: URLComponents
    
    init(path: BanchanUsecase) {
        self.path += path.rawValue
        self.components = URLComponents() //이거 없으면 안돼!
        guard let baseURL = URLComponents(string: "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com") else {
            return
        }
        self.components = baseURL
        self.components.path = self.path
    }
    
    func createValid(url: URL?) throws -> URL {
        guard let validURL = url else {
            throw APIServiceError.wrongURL
        }
        return validURL
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
