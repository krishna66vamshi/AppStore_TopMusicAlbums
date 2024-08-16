//
//  WebServicesProtocol.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import Foundation
import UIKit

protocol WebServicesProtocol {
    func callAPI<T:Codable>(endPoint:Endpoint,modelType:T.Type) async throws -> T
    func downloadImage(urlStr:String) async throws -> UIImage
}

