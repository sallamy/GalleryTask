//
//  GalleryViewController.swift
//  VOISTask
//
//  Created by concarsadmin on 12/22/21.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import SVProgressHUD

class GalleryViewController: UIViewController, UITableViewDelegate {
    
    let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    let  viewModel =  GalleryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.title = "Gallery"
        viewModel.getPhotos()
        buidUI()
        registerTableView()
        bindTableView()
        observeLoading()
        observeSelectModel()
    }
    
    func buidUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        self.tableView.setConstraints(top: self.view.safeAreaLayoutGuide.topAnchor, bottom: self.view.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, paddingTop: 16,paddingLeading: 16, paddingTrailing: 16)
    }
    
    func registerTableView() {
        self.tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.idenetifier)
    }
    
}

// MARK: - RxBinding
extension GalleryViewController {
    
    func observeLoading() {
        viewModel.isLoading.asObservable().subscribe { status in
            if let state = status.element, state == true{
                SVProgressHUD.show()
            }else {
                SVProgressHUD.dismiss()
            }
        }.disposed(by: disposeBag)
    }
    
    func bindTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        self.viewModel.photos.bind(to: tableView.rx.items(cellIdentifier: PhotoTableViewCell.idenetifier)) { row, dataSource, cell in
            guard let cell = cell as? PhotoTableViewCell else { return }
            cell.setupData(model: dataSource, index: row)
        }
        .disposed(by: disposeBag)
    }
    
    func observeSelectModel() {
        self.tableView.rx.modelSelected(PhotoViewData.self).subscribe { event in
            guard let model = event.element else {return}
            let photoDetails = PhotoDetailsViewController(photoUrl: model.photoURL)
            self.navigationController?.pushViewController(photoDetails, animated: true)
        }.disposed(by: disposeBag)
    }
}

// MARK: - tableViewDelegate
extension GalleryViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (self.viewModel.photos.value.count - 2) == indexPath.row && viewModel.fromCashing == false  {
            self.viewModel.getPhotos()
        }
    }
}
