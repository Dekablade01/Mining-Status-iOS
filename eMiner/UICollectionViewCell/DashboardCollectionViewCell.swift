//
//  DashboardCollectionViewCell.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import SnapKit
import Then

class DashboardCollectionViewCell: UICollectionViewCell
{
    var isAddedConstraints = false
    
    lazy var headingView = UIView(frame: CGRect.zero).then(){
        $0.backgroundColor = BootStrapColor.blue
    }
    
    lazy var headingLabel = UILabel().then(){
        $0.textColor = .white
        $0.font = $0.font.withSize(13)
        $0.textAlignment = .center
        $0.numberOfLines = 1


    }
    var heading: String {
        set { headingLabel.text = newValue }
        get { return headingLabel.text ?? "" }
    }
    lazy var valueView = UIView(frame: CGRect.zero).then(){
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
    }
    lazy var valueLabel = UILabel(frame: CGRect.zero).then(){
        $0.textColor = BootStrapColor.black
        $0.layer.borderColor = UIColor.black.cgColor
        $0.numberOfLines = 1
    $0.textAlignment = .center
        $0.font = $0.font.withSize(13)
    }
    var contentValue: String {
        get { return valueLabel.text ?? "" }
        set { valueLabel.text = newValue }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        commonInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit()
    {
        addSubViewToContentView()
        self.setNeedsUpdateConstraints()
    }
    func addSubViewToContentView() {
        contentView.addSubview(valueView)
        contentView.addSubview(valueLabel)
        contentView.addSubview(headingView)
        contentView.addSubview(headingLabel)
        
    }
    func setHeadingBackgroundWith(color: UIColor)
    {
        headingView.backgroundColor = color
    }
    
    override func updateConstraints() {
        if (isAddedConstraints == false)
        {
            headingView.snp.makeConstraints(){
                $0.width.equalTo(contentView)
                $0.centerX.equalTo(contentView)
                $0.top.equalTo(contentView)
                $0.height.equalTo(contentView).dividedBy(2)
            }
            headingLabel.snp.makeConstraints(){
                $0.center.equalTo(headingView)
                $0.width.equalTo(headingView).multipliedBy(0.9)
            
            }
            valueView.snp.makeConstraints(){
                $0.bottom.equalTo(contentView)
                $0.centerX.equalTo(contentView)
                $0.width.equalTo(contentView)
                $0.top.equalTo(headingView.snp.bottom).inset(1)
            }
            valueLabel.snp.makeConstraints(){
                $0.center.equalTo(valueView)
                $0.width.equalTo(valueView).multipliedBy(0.9)
            }
            
            
            isAddedConstraints = true
        }
        super.updateConstraints()
    }
}
