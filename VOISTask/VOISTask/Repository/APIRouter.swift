//
//  APIRouter.swift
//  Task
//
//  Created by mohamed salah
//

import Foundation
import Alamofire


protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
}

struct Constants {
    struct ProductionServer {
        static let baseURL = "https://picsum.photos/v2"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case string = "String"
    
}

enum ContentType: String {
    case json = "application/json"
    case formEncode = "application/x-www-form-urlencoded"
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
}


enum APIRouter: APIConfiguration {
    
    case getPhotos(pageIndex: Int, limit: Int)

    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        }
    }
    // MARK: - Parameters
    var parameters: RequestParams {
        switch self {
       
        case .getPhotos(pageIndex: let index, limit: let size):
            return .url(["page":"\(index)",
                         "limit":"\(size)"])
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getPhotos:
            return "/list"
       
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // Parameters
        switch parameters {
        
        case .body(let params):
            
            urlRequest.httpBody =  try! JSONSerialization.data(withJSONObject: params, options: [])
            
        case .url(let params):
            let queryParams = params.map { pair  in
                return URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        }
        return urlRequest
    }
}


