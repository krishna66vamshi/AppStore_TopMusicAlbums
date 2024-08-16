//
//  WebServicesProtocol.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import Foundation

protocol WebServicesProtocol {
    func callAPI<T:Codable>(endPoint:Endpoint,modelType:T.Type) async throws -> T
}

