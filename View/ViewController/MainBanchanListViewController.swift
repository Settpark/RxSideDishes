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
    private var listDataSource: RxTableViewSectionedReloadDataSource<BanchanSection>!
    
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
        self.listTableView.register(MainViewBanchanCell.self, forCellReuseIdentifier: MainViewBanchanCell.cellidentifier)
        self.view.addSubview(self.listTableView)
        self.listTableView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
    }
    
    func bindViewModel() {
        initDatasource()
    }
}

extension MainBanchanListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewModel = BanChanDetailViewModel(sceneCoordinator: self.viewModel.sceneCoordinator, storage: self.viewModel.storage)
        self.viewModel.sceneCoordinator.transition(to: .Detail(detailViewModel), using: .push, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
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
        
        self.listDataSource.titleForHeaderInSection = { dataSource, index in
            return SectionMainViewTitle.allCases[index].rawValue
        }
        
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
