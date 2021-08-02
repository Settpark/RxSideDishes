//
//  ViewController.swift
//  RxSwiftSidedishes
//
//  Created by 박정하 on 2021/07/26.
//

import UIKit

class MainViewController: UIViewController {
    
    var banchans: Banchans = Banchans.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIService.fetchDataWithSession(API: "/main") { result in
            switch result {
            case .success(let data):
                self.banchans = data
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
}

