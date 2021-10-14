//
//  APIMakerStub.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/30.
//

import Foundation

struct EndpointStub: EndpointManager {
    var defaultPath: String
    
    init() {
        self.defaultPath = ""
    }
    
    func createValidURL(path: String) -> URL {
        let url = Bundle.main.url(forResource: path, withExtension: "json")
        guard let validURL = url else {
            return URL(string: "")!
        }
        
        return validURL
    }
}
