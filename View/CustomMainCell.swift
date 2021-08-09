//
//  CustomMainCell.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/05.
//

import UIKit

class CustomMainCell: UITableViewCell {
    
    private var cellContaionerView: UIStackView
    private var stackviewForbadge: UIStackView
    private var stackviewForDeliveryType: UIStackView
    
    private var containView = UIView()
    
    private var image: UIImage
    private var title: UILabel
    private var banchanDescription: UILabel
    private var sPrice: UILabel
    private var nPrice: UILabel
    private var badge: [UILabel]
    private var deliveryType: [UILabel]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.cellContaionerView = UIStackView()
        self.stackviewForbadge = UIStackView()
        self.stackviewForDeliveryType = UIStackView()
        
        self.image = UIImage()
        self.title = UILabel()
        self.banchanDescription = UILabel()
        self.sPrice = UILabel()
        self.nPrice = UILabel()
        self.badge = []
        self.deliveryType = []
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContents(value: Banchan) {
        self.title.text = value.title
        setConstraintsCellContents()
    }
    
    func setConstraintsCellContents() {
        self.addSubview(self.title)
        self.title.font = .systemFont(ofSize: 20)
        self.title.sizeToFit()
        self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
