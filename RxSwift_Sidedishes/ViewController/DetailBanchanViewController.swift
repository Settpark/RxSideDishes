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
    
    var viewModel: BanChanDetailViewModel!
    
    private let wholeContentView: UIScrollView
    private let contentView: UIStackView
    private let detailScrollView: UIScrollView
    private let detailContentView: UIStackView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.wholeContentView = UIScrollView()
        self.detailScrollView = UIScrollView()
        self.contentView = UIStackView()
        self.contentView.axis = .vertical
        self.contentView.distribution = .equalSpacing
        self.contentView.alignment = .leading
        self.detailContentView = UIStackView()
        self.detailContentView.axis = .horizontal
        self.detailContentView.distribution = .equalSpacing
        self.detailContentView.alignment = .center
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        initBackButton()
        initScrollView()
    }
    
    func bindViewModel() {
        
    }
    
    func initScrollView() {
        self.view.addSubview(wholeContentView)
        self.wholeContentView.addSubview(contentView)
        self.contentView.backgroundColor = .red
        self.wholeContentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.wholeContentView.snp.makeConstraints { [unowned self] make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.contentView.snp.makeConstraints { [unowned self] make in
            make.leading.equalTo(self.wholeContentView.contentLayoutGuide.snp.leading)
            make.top.equalTo(self.wholeContentView.contentLayoutGuide.snp.top)
            make.trailing.equalTo(self.wholeContentView.contentLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.wholeContentView.contentLayoutGuide.snp.bottom)
            make.width.equalTo(self.wholeContentView.frameLayoutGuide.snp.width)
        }
        
        self.contentView.addArrangedSubview(detailScrollView)
        self.detailScrollView.addSubview(detailContentView)
        self.detailScrollView.backgroundColor = .blue
        self.detailScrollView.snp.makeConstraints { [unowned self] make in
            make.leading.equalTo(self.wholeContentView.snp.leading)
            make.top.equalTo(self.wholeContentView.snp.top)
            make.trailing.equalTo(self.wholeContentView.snp.trailing)
            make.height.equalTo(self.wholeContentView.snp.height).multipliedBy(0.4)
        }
        
        self.detailContentView.snp.makeConstraints { [unowned self] make in
            make.leading.equalTo(self.detailScrollView.contentLayoutGuide.snp.leading)
            make.top.equalTo(self.detailScrollView.contentLayoutGuide.snp.top)
            make.trailing.equalTo(self.detailScrollView.contentLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.detailScrollView.contentLayoutGuide.snp.bottom)
            make.height.equalTo(self.detailScrollView.frameLayoutGuide.snp.height)
        }
        
        let uiview = UIView()
        uiview.backgroundColor = .yellow
        self.detailContentView.addArrangedSubview(uiview)
        uiview.snp.makeConstraints { make in
            make.width.equalTo(1000)
        }
    }
    
    func initBackButton() {
        var backButton = UIBarButtonItem(title: "뒤로", style: .done, target: nil, action: nil)
        backButton.rx.action = viewModel.popAction
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backButton
    }
}
