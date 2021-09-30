//
//  Banchan.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/09/30.
//

import Foundation
import UIKit

struct Banchan: Equatable {
    
    let detailHash: String
    let image: UIImage
    let alt: String
    let deliveryType: [String]
    let title: String
    let description: String
    let nPrice: String?
    let sPrice: String
    let badge: [String]?
    
    static var empty = Banchan.init()
    
    init() {
        detailHash = ""
        image = UIImage()
        alt = ""
        deliveryType = []
        title = "빈 더미 더미"
        description = ""
        nPrice = ""
        sPrice = ""
        badge = []
    }
}

