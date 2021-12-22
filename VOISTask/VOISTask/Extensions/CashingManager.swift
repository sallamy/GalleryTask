//
//  CashingManager.swift
//  VOISTask
//
//  Created by concarsadmin on 12/22/21.
//

import Foundation

final class CashingManager {
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
    
    class func  clear() {
        UserDefaults.standard.removeObject(forKey: "photos")
    }
}
