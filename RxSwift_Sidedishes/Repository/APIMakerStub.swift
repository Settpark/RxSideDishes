//
//  APIMakerStub.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/30.
//

import Foundation

struct APIMakerStub: APIMakerType {
    var path: String
    
    init() {
        self.path = ""
    }
    
    func createValidURL(path: BanchanUsecase) -> URL {
        let url = Bundle.main.url(forResource: path.rawValue, withExtension: "json")
        guard let validURL = url else {
            return URL(string: "")!
        }
        
        return validURL
    }
}
