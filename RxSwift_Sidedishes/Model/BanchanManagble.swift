//
//  BanchanManagble.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/10/01.
//

import Foundation
import UIKit

protocol BanchanManagble {    
    var image: UIImage { get set }
    var deliveryType: [String] { get set }
    var title: String { get set }
    var description: String { get set }
    var nPrice: String? { get set }
    var sPrice: String { get set }
    var badge: [String]? { get set }
    
    static var empty: Self {get}
}
