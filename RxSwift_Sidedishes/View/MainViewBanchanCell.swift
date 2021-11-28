//
//  MainViewBanchanCell.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/05.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SnapKit

class MainViewBanchanCell: UITableViewCell {
    
    static let cellidentifier = "MainbanchanCell"
    
    private var cellContainView: UIStackView
    private var stackviewForBadge: UIStackView
    private var stackviewForPrice: UIStackView
    private var stackviewForDeliveryType: UIStackView
    
    private var banchanimage: UIImageView
    private var title: UILabel
    private var banchanDescription: UILabel
    private var sPrice: UILabel
    private var nPrice: UILabel
    private var badge: [UILabel]
    private var deliveryType: [UILabel]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.cellContainView = UIStackView()
        self.cellContainView.axis = .vertical
        self.cellContainView.distribution = .equalSpacing
        self.cellContainView.alignment = .leading
        self.stackviewForPrice = UIStackView()
        self.stackviewForPrice.axis = .horizontal
        self.stackviewForPrice.distribution = .equalSpacing
        self.stackviewForPrice.spacing = 5
        self.stackviewForPrice.alignment = .center
        self.stackviewForBadge = UIStackView()
        self.stackviewForBadge.axis = .horizontal
        self.stackviewForBadge.contentMode = .left
        self.stackviewForBadge.distribution = .equalSpacing
        self.stackviewForBadge.spacing = 5
        self.stackviewForDeliveryType = UIStackView()
        self.stackviewForDeliveryType.axis = .horizontal
        self.stackviewForDeliveryType.contentMode = .left
        self.stackviewForDeliveryType.distribution = .equalSpacing
        self.stackviewForDeliveryType.spacing = 5
        
        self.banchanimage = UIImageView()
        self.title = UILabel()
        self.title.font = .boldSystemFont(ofSize: 15)
        self.title.sizeToFit()
        self.banchanDescription = UILabel()
        self.banchanDescription.font = .systemFont(ofSize: 14)
        self.banchanDescription.numberOfLines = 2
        self.banchanDescription.sizeToFit()
        self.sPrice = UILabel()
        self.sPrice.font = .boldSystemFont(ofSize: 14)
        self.nPrice = UILabel()
        self.nPrice.font = .systemFont(ofSize: 12)
        self.badge = []
        self.deliveryType = []
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.banchanimage.image = nil
        self.title.text = nil
        self.banchanDescription.text = nil
        self.sPrice.text = nil
        self.nPrice.text = nil
        self.badge.removeAll()
        self.deliveryType.removeAll()
        
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
        self.banchanimage.image = value.image
        self.title.text = value.title
        self.banchanDescription.text = value.description
        self.sPrice.text = value.sPrice
        self.nPrice.text = value.nPrice
        self.initbadgeAndDeliveryType(badge: value.badge ?? [], deliveryType: value.deliveryType)
        setConstraintsCellContents()
    }
    
    func setConstraintsCellContents() {
        
        self.addSubview(self.banchanimage)
        self.banchanimage.layer.masksToBounds = true
        self.banchanimage.layer.cornerRadius = 10
        self.banchanimage.snp.makeConstraints() { make in
            make.width.height.equalTo(100)
            make.left.equalTo(self.snp.left).offset(5)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(self.cellContainView)
        self.cellContainView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(self.banchanimage.snp.right).offset(5)
            make.height.equalTo(self).multipliedBy(0.85)
        }
        
        self.cellContainView.addArrangedSubview(self.title)
        
        self.cellContainView.addArrangedSubview(self.banchanDescription)
        self.banchanDescription.snp.makeConstraints { make in
            make.trailing.equalTo(self)
        }
        
        self.cellContainView.addArrangedSubview(self.stackviewForPrice)
        self.stackviewForPrice.snp.makeConstraints { make in
            make.left.equalTo(cellContainView.snp.left)
        }
        
        self.stackviewForPrice.addArrangedSubview(sPrice)
        self.stackviewForPrice.addArrangedSubview(nPrice)
        
        if badge.count != 0 {
            self.cellContainView.addArrangedSubview(self.stackviewForBadge)
            self.cellContainView.snp.makeConstraints { make in
                make.left.equalTo(cellContainView.snp.left)
            }
            
            self.badge.forEach { [unowned self] label in
                self.stackviewForBadge.addArrangedSubview(label)
                label.snp.makeConstraints { make in
                    make.width.equalTo(self).multipliedBy(0.15)
                }
            }
        }
        
        self.cellContainView.addArrangedSubview(self.stackviewForDeliveryType)
        self.stackviewForDeliveryType.snp.makeConstraints { make in
            make.left.equalTo(self.cellContainView.snp.left)
        }
        self.deliveryType.forEach { [unowned self] label in
            self.stackviewForDeliveryType.addArrangedSubview(label)
            label.snp.makeConstraints { make in
                make.width.equalTo(self).multipliedBy(0.15)
            }
        }
    }
    
    func initbadgeAndDeliveryType(badge: [String], deliveryType: [String]) {
        badge.forEach { string in
            let label = UILabel.init(title: string, size: 13)
            label.backgroundColor = UIColor(red: 100/255, green: 168/255, blue: 255/255, alpha: 1)
            label.textColor = .white
            label.textAlignment = .center
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 3;
            self.badge.append(label)
        }
        deliveryType.forEach { string in
            let label = UILabel.init(title: string, size: 13)
            label.backgroundColor = UIColor(red: 100/255, green: 168/255, blue: 255/255, alpha: 0.7)
            label.textColor = .white
            label.textAlignment = .center
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 3;
            self.deliveryType.append(label)
        }
    }
}
