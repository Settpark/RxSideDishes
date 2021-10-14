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
        self.view.addSubview(tempImageView)
        self.tempImageView.translatesAutoresizingMaskIntoConstraints = false
        self.tempImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.tempImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.tempImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.tempImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.tempImageView.image = UIImage(contentsOfFile: "https://public.codesquad.kr/jk/storeapp/data/2d3f99a9a35601f4e98837bc4d39b2c8.jpg")
    }
    
    func bindViewModel() {
        var backButton = UIBarButtonItem(title: "뒤로", style: .done, target: nil, action: nil)
        backButton.rx.action = viewModel.popAction
//        navigationItem.backBarButtonItem = backButton
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backButton
    }
}
