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
    
    let photos: BehaviorRelay<[PhotoViewData]> = BehaviorRelay(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    var pageIndex = 1
    var fromCashing = false
    // MARK: - CallApi
    func getPhotos(){
        self.isLoading.accept(true)
        GalleryRepository.getPhotos(pageIndex: pageIndex) { [weak self] success, error, photos in
            guard let self = self else {  return}
            self.isLoading.accept(false)
            if success {
                self.pageIndex += 1
                self.photos.accept(self.photos.value + (photos ?? []))
            }else  {
                self.fromCashing = true
                self.photos.accept(photos ?? [])
            }
        }
    }
    
}
