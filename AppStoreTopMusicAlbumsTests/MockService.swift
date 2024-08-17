//
//  MockService.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 17/08/24.
//

import Foundation

class MockApiService: WebServicesProtocol {
    
    var shouldReturnError = false

    
    func callAPI<T>(endPoint: Endpoint, modelType: T.Type) async throws -> T where T : Decodable, T : Encodable {
        
        if shouldReturnError{
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        }
        
        let path = Bundle.main.path(forResource: "mockdata", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        do{
            let users = try JSONDecoder().decode(T.self, from: data)
//            shouldReturnError = false
            return users
        }catch {
//            shouldReturnError = true
        }
        
        throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock error"])

    }
    
   
}
