//
//  DetailData.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/11/29.
//

import Foundation

struct DetailData: Decodable {
    var topImage: String
    var thumbImages: [String]
    var productDescription: String
    var point: String
    var deliveryInfo: String
    var deliveryFee: String
    var prices: [String]
    var detailSection: [String]
}
