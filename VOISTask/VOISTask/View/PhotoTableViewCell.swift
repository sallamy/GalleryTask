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
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .darkGray
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        randomImageView.addSubview(indicatorView)
        indicatorView.setConstraints( centerX: randomImageView.centerXAnchor, centerY: randomImageView.centerYAnchor)
        randomImageView.setConstraints(height: 200)
        adBannerView.setConstraints(height: 100)
        adBannerView.addSubview(adBannerLabel)
        adBannerLabel.setConstraints( centerX: adBannerView.centerXAnchor, centerY: adBannerView.centerYAnchor)
        self.addSubview(stack)
        stack.setConstraints(top: self.topAnchor,bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor,paddingTop: 10,paddingBottom: 10)
    }
    
    func setupData(model: PhotoViewData, index: Int){
        nameLabel.text = model.authorName
        if let photoURL =  URL(string: model.photoURL){
            self.indicatorView.startAnimating()
            self.indicatorView.isHidden = false
            randomImageView.sd_setImage(with: photoURL) { [weak self] image, error, type, url in
                guard let self = self else {  return}
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
            }
        }
        if index%5 == 0 {
            self.adBannerView.isHidden = false
        }else {
            self.adBannerView.isHidden = true
        }
    }
}
