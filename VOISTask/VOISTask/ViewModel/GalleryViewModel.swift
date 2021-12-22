//
//  GalleryViewModel.swift
//  VOISTask
//
//  Created by concarsadmin on 12/22/21.
//

import Foundation
import RxSwift
import RxRelay

final class GalleryViewModel {
    
    let photos: BehaviorRelay<[PhotoViewData]?> = BehaviorRelay(value: nil)
    let isLoading = BehaviorRelay<Bool>(value: false)
    var pageIndex = 1
    
    func getPhotos(){
        self.isLoading.accept(true)
        GalleryRepository.getPhotos(pageIndex: pageIndex) { [weak self] success, error, photos in
            guard let self = self else {  return}
            self.isLoading.accept(false)
            if success {
                self.pageIndex += 1
                self.photos.accept(photos)
            }
        }
    }
}
