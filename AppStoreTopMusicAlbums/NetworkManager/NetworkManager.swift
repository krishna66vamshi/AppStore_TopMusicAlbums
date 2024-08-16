//
//  NetworkManager.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import Foundation

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
    
}
