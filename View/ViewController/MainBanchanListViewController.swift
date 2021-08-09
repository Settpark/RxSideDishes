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
        self.listTableView.register(CustomMainCell.self, forCellReuseIdentifier: "myCell")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? CustomMainCell else {
            return
        }
        print("selectedCell's(\(indexPath.row)) title: \(cell.title.text)")
    }
}

extension MainBanchanListViewController {
    
    private func initDatasource() {
        self.listDataSource = RxTableViewSectionedReloadDataSource<BanchanSection>(configureCell: {
            (datasource, tableView, indexPath, element) -> UITableViewCell in
            let cell: CustomMainCell = self.getTableViewCell(tableView, indexPath: indexPath, item: element)
            cell.setContents(value: element)
            return cell
        })
        
        self.listDataSource.titleForHeaderInSection = { dataSource, index in
            return "header" + String(index)
        }
        
        self.listDataSource.titleForFooterInSection = { dataSource, index in
            return "footer" + String(index)
        }
        
        self.viewModel
            .banchanList
            .debug()
            .asObservable()
            .bind(to: listTableView.rx.items(dataSource: self.listDataSource))
            .disposed(by: rx.disposeBag)
    }
    
    private func getTableViewCell(_ tableView: UITableView, indexPath: IndexPath, item: Banchan) -> CustomMainCell {
        var cell: CustomMainCell
        let section: BanchanSection.Sectionitem = BanchanSection.getSctionType(indexPath.section)
        switch section {
        case .main: cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomMainCell
            break
        case .soup: cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomMainCell
            break
        case .side: cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomMainCell
            break
            
        }
        return cell
    }
}
