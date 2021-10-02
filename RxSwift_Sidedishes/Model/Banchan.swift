//
//  Banchan.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/09/30.
//

import Foundation
import UIKit

struct Banchan: Equatable, BanchanManagble {
    
    var detailHash: String
    var image: UIImage
    var alt: String
    var deliveryType: [String]
    var title: String
    var description: String
    var nPrice: String?
    var sPrice: String
    var badge: [String]?
    
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
    
    init(hash: String, image: UIImage, alt: String, deliveryType: [String], title: String, description: String, nPrice: String?, sPrice: String, badge: [String]?) {
        self.detailHash = hash
        self.image = image
        self.alt = alt
        self.deliveryType = deliveryType
        self.title = title
        self.description = description
        self.nPrice = nPrice
        self.sPrice = sPrice
        self.badge = badge
    }
}

