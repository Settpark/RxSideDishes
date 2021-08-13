//
//  MainViewBanchanCell.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/05.
//

import UIKit
import RxSwift
import NSObject_Rx

class MainViewBanchanCell: UITableViewCell {
    
    static let cellidentifier = "MainbanchanCell"
    
    private var cellContainView: UIStackView
    private var stackviewForBadge: UIStackView
    private var stackviewForPrice: UIStackView
    private var stackviewForDeliveryType: UIStackView
        
    private var image: UIImageView
    private var title: UILabel
    private var banchanDescription: UILabel
    private var sPrice: UILabel
    private var nPrice: UILabel
    private var badge: [UILabel]
    private var deliveryType: [UILabel]
    
    var ob_image: Observable<UIImageView> = PublishSubject<UIImageView>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.cellContainView = UIStackView()
        cellContainView.axis = .vertical
        self.cellContainView.distribution = .equalSpacing
        self.cellContainView.alignment = .leading
        self.stackviewForPrice = UIStackView()
        stackviewForPrice.axis = .horizontal
        stackviewForPrice.distribution = .fillEqually
        stackviewForPrice.alignment = .leading
        self.stackviewForBadge = UIStackView()
        stackviewForBadge.axis = .horizontal
        stackviewForBadge.contentMode = .left
        self.stackviewForDeliveryType = UIStackView()
        stackviewForDeliveryType.axis = .horizontal
        stackviewForDeliveryType.contentMode = .left
        
        self.image = UIImageView()
        self.title = UILabel()
        self.banchanDescription = UILabel()
        self.sPrice = UILabel()
        self.nPrice = UILabel()
        self.badge = []
        self.deliveryType = []
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.title.text = nil
        self.banchanDescription.text = nil
        self.sPrice.text = nil
        self.nPrice.text = nil
        self.badge.forEach { view in
            view.text = nil
        }
        self.deliveryType.forEach { view in
            view.text = nil
        }
        stackviewForPrice.subviews.forEach { view in
            view.removeFromSuperview()
        }
        stackviewForBadge.subviews.forEach { view in
            view.removeFromSuperview()
        }
        stackviewForDeliveryType.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContents(value: Banchan) {
        self.title.text = value.title
        self.banchanDescription.text = value.description
        self.sPrice.text = value.sPrice
        self.nPrice.text = value.nPrice
        self.initbadgeAndDeliveryType(badge: value.badge ?? [], deliveryType: value.deliveryType)
        setConstraintsCellContents()
    }
    
    func setConstraintsCellContents() {
//        self.translatesAutoresizingMaskIntoConstraints = false //여기까지 내가 컨트롤 하고 싶은데 튀어버림
//        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        self.widthAnchor.constraint(equalToConstant: 500).isActive = true
        
        self.addSubview(self.image)
        self.image.translatesAutoresizingMaskIntoConstraints = false
        self.image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.image.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.addSubview(self.cellContainView)
        self.cellContainView.frame.size = CGSize(width: self.frame.width - self.image.frame.width - 1, height: self.frame.height - 1)
        self.cellContainView.translatesAutoresizingMaskIntoConstraints = false
        self.cellContainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 1).isActive = true
        self.cellContainView.leadingAnchor.constraint(equalTo: self.image.trailingAnchor, constant: 1).isActive = true
        self.cellContainView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.cellContainView.addArrangedSubview(self.title)
        self.title.font = .systemFont(ofSize: 15)
        self.title.sizeToFit()
        
        self.cellContainView.addArrangedSubview(self.banchanDescription)
        self.banchanDescription.font = .systemFont(ofSize: 15)
        self.banchanDescription.sizeToFit()
        
        self.cellContainView.addArrangedSubview(self.stackviewForPrice)
        self.stackviewForPrice.translatesAutoresizingMaskIntoConstraints = false
        self.stackviewForPrice.leadingAnchor.constraint(equalTo: self.cellContainView.leadingAnchor).isActive = true
        
        self.stackviewForPrice.addArrangedSubview(sPrice)
        self.stackviewForPrice.addArrangedSubview(nPrice)
        
        self.cellContainView.addArrangedSubview(self.stackviewForBadge)
        self.stackviewForBadge.translatesAutoresizingMaskIntoConstraints = false
        self.stackviewForBadge.leadingAnchor.constraint(equalTo: self.cellContainView.leadingAnchor).isActive = true
        
        self.badge.forEach { label in
            self.stackviewForBadge.addArrangedSubview(label)
        }
        
        self.cellContainView.addArrangedSubview(self.stackviewForDeliveryType)
        self.stackviewForDeliveryType.translatesAutoresizingMaskIntoConstraints = false
        self.stackviewForDeliveryType.leadingAnchor.constraint(equalTo: self.cellContainView.leadingAnchor).isActive = true
        
        self.deliveryType.forEach { label in
            self.stackviewForDeliveryType.addArrangedSubview(label)
        }
    }
    
    func initbadgeAndDeliveryType(badge: [String], deliveryType: [String]) {
        badge.forEach { string in
            let label = UILabel.init(title: string)
            self.badge.append(label)
        }
        deliveryType.forEach { string in
            let label = UILabel.init(title: string)
            self.deliveryType.append(label)
        }
    }
}
