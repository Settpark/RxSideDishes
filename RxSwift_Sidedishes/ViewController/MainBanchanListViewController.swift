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

class MainBanchanListViewController: UIViewController, ViewModelBindableType, AlertController {
    
    var viewModel: BanchanListViewModel!
    private var listTableView: UITableView
    private var listDataSource: RxTableViewSectionedReloadDataSource<BanchanSection>!
    private var data222 = Banchans.init()
    
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
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func initTableView() {
        let tableViewSize = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.listTableView.frame = tableViewSize
        self.listTableView.register(MainViewBanchanCell.self, forCellReuseIdentifier: MainViewBanchanCell.cellidentifier)
        self.listTableView.backgroundColor = .white
        self.view.addSubview(self.listTableView)
        setConstraintlistTableView()
        self.listTableView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
    }
    
    func bindViewModel() {
        viewModel.delegate = self
        initDatasource()
        self.viewModel.handlingError()
    }
    
    func showAlertController(error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController.init(title: error.localizedDescription, message: error.localizedDescription, preferredStyle: .alert)
            let alertaction = UIAlertAction.init(title: ButtonTitle.확인.rawValue, style: .destructive, handler: nil)
            alertController.addAction(alertaction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setConstraintlistTableView() {
        self.listTableView.translatesAutoresizingMaskIntoConstraints = false
        self.listTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.width.equalTo(self.view.safeAreaLayoutGuide.snp.width)
            make.height.equalTo(self.view.safeAreaLayoutGuide.snp.height)
        }
    }
}

extension MainBanchanListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewModel = BanChanDetailViewModel(sceneCoordinator: self.viewModel.sceneCoordinator, useCase: self.viewModel.useCase)
        self.viewModel.sceneCoordinator.transition(to: .Detail(detailViewModel), using: .push, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: .zero, y: .zero, width: self.view.frame.width, height: self.view.frame.height))
        headerView.backgroundColor = .white

        let title = UILabel.init(title: SectionMainViewTitle.allCases[section].rawValue, size: TableViewSizeProperties.headerViewSize.rawValue)
        title.font = .boldSystemFont(ofSize: 20)
        title.sizeToFit()
        headerView.addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.equalTo(headerView).offset(15)
            make.centerY.equalTo(headerView)
        }
        return headerView
    }
}

enum TableViewSizeProperties: CGFloat {
    case tableViewRatio = 8
    case headerViewSize = 24
}

extension MainBanchanListViewController {
    
    private func initDatasource() {
        self.listDataSource = RxTableViewSectionedReloadDataSource<BanchanSection>(configureCell: {
            (datasource, tableView, indexPath, element) -> UITableViewCell in
            guard let cell: MainViewBanchanCell = tableView.dequeueReusableCell(withIdentifier: MainViewBanchanCell.cellidentifier) as? MainViewBanchanCell else {
                return UITableViewCell()
            }
            
            cell.setContents(value: element)
            return cell
        })
        
        self.viewModel
            .banchanList
            .bind(to: listTableView.rx.items(dataSource: self.listDataSource))
            .disposed(by: rx.disposeBag)
    }
}

enum SectionMainViewTitle: String, CaseIterable {
    case main = "모두가 좋아하는 든든한 메인요리"
    case soup = "정성이 담긴 뜨끈뜨끈 국물요리"
    case side = "식탁을 풍성하게 하는 정갈한 밑반찬"
}
