//
//  Banchan.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/07/29.
//

import Foundation

struct BanchanDTO: Decodable, Equatable {
    
    let detailHash: String
    let image: String
    let alt: String
    let deliveryType: [String]
    let title: String
    let description: String
    let nPrice: String?
    let sPrice: String
    let badge: [String]?
    
    static var empty = BanchanDTO.init()
    
    init() {
        detailHash = ""
        image = ""
        alt = ""
        deliveryType = []
        title = "빈 더미 더미"
        description = ""
        nPrice = ""
        sPrice = ""
        badge = []
    }
}
