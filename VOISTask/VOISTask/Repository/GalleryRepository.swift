//
//  FourSquareRepository.swift
//  Task
//
//  Created by  mohamed salah
//

import Foundation
import UIKit
import Alamofire

final class GalleryRepository {
    
    static let pageSize = 10
    class func getPhotos(pageIndex: Int,
                         complete: @escaping(_ success: Bool,
                                            _ error: String?,
                                            _ photos: [PhotoViewData]?)->Void) {
        AF.request(APIRouter.getPhotos(pageIndex: pageIndex,
                                       limit: pageSize)).validate().responseDecodable { (response: DataResponse<[Photo]?, AFError>) in
            
            switch response.result {
            case .success(let response):
                if pageIndex == 1 {
                    CashingManager.save(photos: response ?? [])
                }
                complete(true,nil,response)
                break
            case .failure(let error):
                let photos = CashingManager.getPhotos()
                complete(false, error.errorDescription, photos)
                break
            }
        }
    }
}

