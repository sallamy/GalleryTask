//
//  VOISTaskTests.swift
//  VOISTaskTests
//
//  Created by concarsadmin on 12/22/21.
//

import XCTest
@testable import VOISTask

class VOISTaskTests: XCTestCase {
    
    
    
    func testDecodingPhotoModel()  {
        let jsonPhoto = [
            "id":"0",
            "author":"Alejandro Escamilla",
            "width":5616,
            "height":3744,
            "url":"https://unsplash.com/photos/yC-Yzbqy7PY",
            "download_url":"https://picsum.photos/id/0/5616/3744" ] as [String : Any]
      
        do {
            let photoData = try jsonPhoto.toData(options: .prettyPrinted)
            let photoModel = try JSONDecoder().decode(Photo.self, from: photoData)
            XCTAssertNotNil(photoModel)
            
        } catch  {
        
        }
    }
    
    func testApi() {
        let expectation = self.expectation(description: "Response Come")
        var resultPhotos: [PhotoViewData]?
        GalleryRepository.getPhotos(pageIndex: 1) {  success, error, photos in
            resultPhotos = photos
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(resultPhotos)
    }
    
    
}

extension Dictionary {
    func toData(options: JSONSerialization.WritingOptions = []) throws -> Data {
        return try JSONSerialization.data(withJSONObject: self, options: options)
    }
}
