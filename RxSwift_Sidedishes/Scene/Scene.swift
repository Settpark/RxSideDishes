//
//  Scene.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/02.
//

import UIKit

enum Scene {
    case MainList(BanchanListViewModel)
    case Detail
}

extension Scene {
    func instantiate(from Storyboard: String = "Main") -> UIViewController {
        
        switch self {
        case .MainList(let viewModel):
            let nav = UINavigationController(rootViewController: MainBanchanListViewController()) 
            guard var listVC = nav.viewControllers.first as? MainBanchanListViewController else {
                fatalError()
            }
            listVC.bind(viewModel: viewModel)
            return nav
        case .Detail:
            print("아직")
            return UIViewController()
        }
    }
}
