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
    
    var ob_image: Observable<UIImageView> = PublishSubject<UIImageView>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.cellContainView = UIStackView()
        cellContainView.axis = .vertical
        self.cellContainView.distribution = .fillEqually
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
        
        self.banchanimage = UIImageView()
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
        self.banchanimage.image = nil
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
        self.banchanimage.snp.makeConstraints() { make in
            make.width.height.equalTo(100)
            make.left.equalTo(self.snp.left).offset(5)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(self.cellContainView)
        self.cellContainView.snp.makeConstraints { make in
            make.left.equalTo(self.banchanimage.snp.right).offset(5)
            make.height.equalTo(self)
        }
        
        self.cellContainView.addArrangedSubview(self.title)
        self.title.font = .boldSystemFont(ofSize: 15)
        self.title.sizeToFit()
        
        self.cellContainView.addArrangedSubview(self.banchanDescription)
        self.banchanDescription.font = .systemFont(ofSize: 15)
        self.banchanDescription.sizeToFit()
        
        self.cellContainView.addArrangedSubview(self.stackviewForPrice)
        self.stackviewForPrice.snp.makeConstraints { make in
            make.left.equalTo(cellContainView.snp.left)
        }
        
        self.stackviewForPrice.addArrangedSubview(sPrice)
        self.stackviewForPrice.addArrangedSubview(nPrice)
        
        self.cellContainView.addArrangedSubview(self.stackviewForBadge)
        self.cellContainView.snp.makeConstraints { make in
            make.left.equalTo(cellContainView.snp.left)
        }
        
        self.badge.forEach { label in
            self.stackviewForBadge.addArrangedSubview(label)
        }
        
        self.cellContainView.addArrangedSubview(self.stackviewForDeliveryType)
        self.stackviewForDeliveryType.snp.makeConstraints { make in
            make.left.equalTo(self.cellContainView.snp.left)
        }
        
        self.deliveryType.forEach { label in
            self.stackviewForDeliveryType.addArrangedSubview(label)
        }
    }
    
    func initbadgeAndDeliveryType(badge: [String], deliveryType: [String]) {
        badge.forEach { string in
            let label = UILabel.init(title: string, size: 14)
            self.badge.append(label)
        }
        deliveryType.forEach { string in
            let label = UILabel.init(title: string, size: 14)
            self.deliveryType.append(label)
        }
    }
}
