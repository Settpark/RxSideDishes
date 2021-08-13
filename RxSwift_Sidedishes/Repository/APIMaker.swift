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
    
    init(path: String) {
        self.path += path
        self.components = URLComponents()
        guard let baseURL = URLComponents(string: "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com") else {
            return
        }
        self.components = baseURL
        self.components.path = self.path
    }
}
