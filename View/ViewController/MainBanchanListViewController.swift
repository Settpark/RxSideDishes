//
//  MainBanchanListViewController.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/02.
//

import UIKit

class MainBanchanListViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: BanchanListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func bindViewModel() {
        //
    }
}
