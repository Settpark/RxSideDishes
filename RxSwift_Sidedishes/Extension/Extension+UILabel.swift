//
//  Extension.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/05.
//

import UIKit

extension UILabel {
    convenience init(title: String) {
        self.init(frame: .zero)
        self.text = title
        self.font = .systemFont(ofSize: 14)
        self.sizeToFit()
    }
    
    func initLabels(titles: [String]) -> [UILabel] {
        var labels: [UILabel] = []
        for i in 0..<labels.count {
            labels[i] = UILabel(title: titles[i])
        }
        return labels
    }
}
