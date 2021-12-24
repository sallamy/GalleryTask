//
//  PhotoDetailsViewController.swift
//  VOISTask
//
//  Created by concarsadmin on 12/22/21.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    lazy var indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .medium)
        view.color = .darkGray
      view.startAnimating()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    private lazy var backGroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private  var photoUrl: String?
    
    init(photoUrl: String?) {
        super.init(nibName: nil, bundle: nil)
        self.photoUrl = photoUrl
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    func buildUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(backGroundImageView)
        backGroundImageView.fillSuperView(self.view)
        self.view.addSubview(indicatorView)
        indicatorView.setConstraints( centerX: self.view.centerXAnchor, centerY: self.view.centerYAnchor )
        if let photoURL =  URL(string: self.photoUrl ?? ""){
            self.indicatorView.startAnimating()
            self.indicatorView.isHidden = false
            backGroundImageView.sd_setImage(with: photoURL) { [weak self] image, error, type, url in
                guard let self = self else {  return}
                self.backGroundImageView.backgroundColor = image?.averageColor
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
            }
        }
      
    }
    
}
