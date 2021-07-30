//
//  BanChans.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/07/29.
//

import Foundation

class BanChans: Decodable {
    var body: [Banchan]
    
    init() {
        body = []
    }
}
