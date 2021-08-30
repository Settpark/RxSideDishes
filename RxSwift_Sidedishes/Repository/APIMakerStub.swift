//
//  APIMakerStub.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/30.
//

import Foundation

struct APIMakerStub: APIMakerType {
    var path: String = ""
    var components: URLComponents
    
    init(testPath: BanchanUsecase) {
        let url = Bundle.main.path(forResource: testPath, ofType: <#T##String?#>)
        self.components = URLComponents.init(string: <#T##String#>)
        self.components.url = Bundle.main.url(forResource: testPath, withExtension: "json")
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
    
    func decodeData<T>(type: T.Type, data: Data) -> Result<T, Error> where T : Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return Result.success(try decoder.decode(T.self, from: data))
        } catch {
            return Result.failure(error)
        }
    }
}
