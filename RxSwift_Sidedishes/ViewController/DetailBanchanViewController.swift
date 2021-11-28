//
//  DetailBanchanViewController.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/12.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources

class DetailBanchanViewController: UIViewController, ViewModelBindableType {    
    var tempImageView: UIImageView
    var viewModel: BanChanDetailViewModel!
    
    private let detailScrollView: UIScrollView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.tempImageView = UIImageView()
        self.detailScrollView = UIScrollView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func bindViewModel() {
        var backButton = UIBarButtonItem(title: "뒤로", style: .done, target: nil, action: nil)
        backButton.rx.action = viewModel.popAction
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backButton
    }
}
