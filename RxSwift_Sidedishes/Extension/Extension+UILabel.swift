//
//  Extension.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/05.
//

import UIKit

extension UILabel {
    convenience init(title: String, size: CGFloat) {
        self.init(frame: .zero)
        self.text = title
        self.font = .systemFont(ofSize: size)
        self.sizeToFit()
    }
    
    func initLabels(titles: [String], size: CGFloat) -> [UILabel] {
        var labels: [UILabel] = []
        for i in 0..<labels.count {
            labels[i] = UILabel(title: titles[i], size: size)
        }
        return labels
    }
}
