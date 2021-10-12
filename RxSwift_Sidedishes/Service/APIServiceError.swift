//
//  APIServiceError.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/24.
//

import Foundation

enum APIServiceError: String, Error {
    case wrongURL
    case wrongRequest
    case failedDecoding = "FailedDecoding"
    case unknown
}
