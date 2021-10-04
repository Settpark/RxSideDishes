//
//  APIMaker.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/13.
//

import Foundation

struct APIMaker: APIMakerType {
    var path: String = "/develop/baminchan/"
    
    func createValidURL(path: BanchanUsecase) -> URL {
        let newPath = self.path + path.rawValue
        guard let baseURL = URLComponents(string: "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com") else {
            return URL(string: "")! //여기를 어떻게 못하나..?
        }
        var urlComponents = URLComponents.init()
        urlComponents = baseURL
        urlComponents.path = newPath
        
        guard let result = urlComponents.url else {
            return URL(string: "")!
        }
        
        return result
    }
}
