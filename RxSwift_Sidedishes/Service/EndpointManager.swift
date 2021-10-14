//
//  APIMakeType.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/13.
//

import Foundation

protocol EndpointManager {
    var defaultPath: String { get set }
    func createValidURL(path: String) -> URL
}
