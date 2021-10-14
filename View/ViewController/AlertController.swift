//
//  AlertController.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/24.
//

import Foundation
import UIKit

protocol AlertController {
    func showAlertController(error: Error)
}

enum ButtonTitle: String {
    case 확인
    case 닫기
}
