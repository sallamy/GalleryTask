//
//  CashingManager.swift
//  VOISTask
//
//  Created by concarsadmin on 12/22/21.
//

import Foundation

final class CashingManager {
    
    // MARK: - save photo
    class func save(photos: [Photo]){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(photos)
            UserDefaults.standard.set(data, forKey: "photos")
            UserDefaults.standard.synchronize()
        } catch {
            print("Debug: \(error)")
        }
    }
    
    // MARK: - get photo
    class func getPhotos() -> [Photo] {
        do {
            let decoder = JSONDecoder()
            if let data = UserDefaults.standard.data(forKey: "photos"){
                let photos = try decoder.decode([Photo].self, from: data)
                return photos
            }
        } catch {
            print("Debug: \(error)")
        }
        return []
    }
    // MARK: - Clear
    class func  clear() {
        UserDefaults.standard.removeObject(forKey: "photos")
    }
}
