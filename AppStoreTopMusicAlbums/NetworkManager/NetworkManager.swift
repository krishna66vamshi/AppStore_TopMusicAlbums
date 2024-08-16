//
//  NetworkManager.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import Foundation
import UIKit

enum NetworkError : Error{
    case invalidData
    case invalidURL
    case invalidStatusCode
    case decodeError(err:Error)
    case unkownError(err:Error)
    
    var errorDescription:String{
        switch self {
        case .invalidURL:
            return "invalidURL"
        case .invalidData:
            return "invalid Data"
        case .invalidStatusCode:
            return "invalidStatusCode"
        case .decodeError(let err):
            return err.localizedDescription
        case .unkownError(let err):
            return err.localizedDescription
        }
    }
}

struct NetworkManager:WebServicesProtocol {
        
    func callAPI<T:Codable>(endPoint:Endpoint,modelType:T.Type) async throws -> T{
            
        guard let url = endPoint.url else{
            throw NetworkError.invalidURL
        }
        
        do{
            let (data,response) = try await URLSession.shared.data(from: url)
            guard let resp = response as? HTTPURLResponse , (200...299).contains(resp.statusCode) else{
                throw NetworkError.invalidStatusCode
            }
            return  try JSONDecoder().decode(T.self, from: data)
        }catch let err{
            if let e = err as? DecodingError{
                throw NetworkError.decodeError(err: e)
            }else{
                throw NetworkError.unkownError(err: err)
            }
        }
        
    }

    func downloadImage(urlStr: String) async throws -> UIImage {
        
        guard let url = URL(string: urlStr) else{
            throw NetworkError.invalidURL
        }
        
        // Check if the image is cached
        if let cachedImage = ImageCache.shared.getImage(forKey: urlStr) {
            return cachedImage
        }
        
        do{
            let (data,response) = try await URLSession.shared.data(from: url)
            guard let resp = response as? HTTPURLResponse , (200...299).contains(resp.statusCode) else{
                throw NetworkError.invalidStatusCode
            }
            
            if let image = UIImage(data: data){
                // Cache the image
                ImageCache.shared.saveImage(image, forKey: urlStr)
                return image
            }
            
        }catch let err{
            if let e = err as? DecodingError{
                throw NetworkError.decodeError(err: e)
            }else{
                throw NetworkError.unkownError(err: err)
            }
        }
        
        throw NetworkError.invalidData
    }
}
