//
//  MainBanchanListViewController.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/02.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources

class MainBanchanListViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: BanchanListViewModel!
    private var listTableView: UITableView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.listTableView = UITableView()
        super.init(nibName: nil, bundle: nil)
        initTableView()
    }
    
    required init?(coder: NSCoder) {
        self.listTableView = UITableView()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        super.viewDidLoad()
    }
    
    func initTableView() {
        let tableViewSize = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.listTableView.frame = tableViewSize
        self.listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.view.addSubview(self.listTableView)
    }
    
    func bindViewModel() {
        viewModel.banchanList
            .bind(to: listTableView.rx.items(cellIdentifier: "myCell")) { row, banchan, cell in
                cell.textLabel?.text = banchan.title
            }
            .disposed(by: rx.disposeBag)
    }
}
