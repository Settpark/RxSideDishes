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
        view.backgroundColor = .white
        let label = addLabel()
        view.addSubview(label)
        constraintlabel(label: label)
    }
    
    func addLabel() -> UILabel {
        let Label = UILabel()
        Label.text = "초기화"
        Label.font = UIFont.systemFont(ofSize: 20)
        return Label
    }
    
    func constraintlabel(label: UILabel) {
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}

