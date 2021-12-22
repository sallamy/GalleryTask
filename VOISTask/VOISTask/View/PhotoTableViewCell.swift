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
        self.addSubview(nameLabel)
        self.addSubview(randomImageView)
        randomImageView.setConstraints(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor , paddingTop: 10, paddingLeading: 16,paddingTrailing: 16)
        
        nameLabel.setConstraints(top: randomImageView.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor , paddingTop: 10, paddingLeading: 16,paddingTrailing: 16)
        
    }
 
    func setupData(model: PhotoViewData){
        nameLabel.text = model.authorName
        if let photoURL =  URL(string: model.photoURL){
            randomImageView.sd_setImage(with: photoURL, placeholderImage: nil)
        }
    }
}
