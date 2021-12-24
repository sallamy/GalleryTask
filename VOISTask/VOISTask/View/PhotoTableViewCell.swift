//
//  PhotoTableViewCell.swift
//  VOISTask
//
//  Created by concarsadmin on 12/22/21.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {
    static let idenetifier = "PhotoTableViewCell"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor.black
        label.textAlignment = .justified
        return label
    }()
  
    lazy var randomImageView: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    lazy var adBannerLabel: UILabel = {
        let label = UILabel()
        label.text = "Ad Banner"
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor.darkGray
        label.textAlignment = .justified
        return label
    }()
    
    lazy var adBannerView: UIView = {
        let adView = UIView()
        adView.backgroundColor = UIColor.lightGray
        return adView
    }()
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    func buildUI(){
        self.backgroundColor  = UIColor.white
        self.selectionStyle = .none
        let stack = UIStackView()
        stack.spacing = 5
        stack.distribution = .fill
        stack.axis = .vertical
        stack.addArrangedSubview(randomImageView)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(adBannerView)

        randomImageView.setConstraints(height: 200)
        adBannerView.setConstraints(height: 100)
        adBannerView.addSubview(adBannerLabel)
        adBannerView.setConstraints( centerX: adBannerView.centerXAnchor, centerY: adBannerView.centerYAnchor)
        self.addSubview(stack)
        stack.setConstraints(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor)
    }
 
    func setupData(model: PhotoViewData, index: Int){
        nameLabel.text = model.authorName
        if let photoURL =  URL(string: model.photoURL){
            randomImageView.sd_setImage(with: photoURL, placeholderImage: nil)
        }
        if index%5 == 0 {
            self.adBannerView.isHidden = false
        }else {
            self.adBannerView.isHidden = true
        }
    }
}
