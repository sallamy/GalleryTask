//
//  Photo.swift
//  VOISTask
//
//  Created by sala7 on 12/22/21.
//

import Foundation

protocol PhotoViewData {
    var authorName: String { get }
    var photoURL: String { get }
}

struct Photo: Codable {
    private let id: String?
    private let author: String?
    private let width: Int?
    private let height: Int?
    private let url: String?
    private let download_url: String?
}

extension Photo: PhotoViewData {
    var authorName: String {
        return author ?? ""
    }
    
    var photoURL: String {
        return download_url ?? ""
    }
}
