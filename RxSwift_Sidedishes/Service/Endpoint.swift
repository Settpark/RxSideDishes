//
//  APIMaker.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/13.
//

import Foundation

struct EndPoint: EndpointManager {
    var defaultPath: String = "/develop/baminchan/"
    
    func createValidURL(path: String) -> URL {
        let newPath = self.defaultPath + path
        
        guard let baseURL = URLComponents(string: "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com") else {
            return URL(string: "")!
            
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
