//
//  DecodedData.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/30.
//

import Foundation

class DecodedData {
    private var decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    func testData() -> [BanchanSection] {
        var result: [BanchanSection] = []
        for index in BanchanUsecase.allCases {
            let path = Bundle.main.url(forResource: index.rawValue, withExtension: "json")
            let data = try! Data.init(contentsOf: path!)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try! decoder.decode(Banchans.self, from: data)
//            let sectionData = BanchanSection.init(sectionitem: index, items: decodedData.body)
//            result.append(sectionData)
        }
        let copysection = [result[1], result[0], result[2]]
        return copysection
    }
}
