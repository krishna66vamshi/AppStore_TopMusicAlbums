//
//  AppStoreTopMusicAlbumsTests.swift
//  AppStoreTopMusicAlbumsTests
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import XCTest
@testable import AppStoreTopMusicAlbums

final class AppStoreTopMusicAlbumsTests: XCTestCase {
    
    var sut:FeedListViewModel!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockApiService()
        sut = FeedListViewModel(webServices:mockAPIService)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_api_fetch_success() async{
        mockAPIService.shouldReturnError = false
        await sut.callAPI()
        XCTAssertEqual(sut.albumsResults.count, 50 )
    }
    
    func test_api_fetch_failure() async{
        mockAPIService.shouldReturnError = true
        await sut.callAPI()
        XCTAssertEqual(sut.albumsResults.count, 0 )
    }
    
    func test_fetch_albums_count() async{
        await sut.callAPI()
        
        XCTAssertEqual(sut.getNoOfRows, 50 )
    }
    
    func test_fetch_albumsFirstArtistName() async{
        await sut.callAPI()
        XCTAssertEqual(sut.albumsResults.first?.artistName ?? "", "Post Malone","Artists Name shouldn't match" )
    }
    
    func test_fetch_albumsLastArtistName() async{
        await sut.callAPI()
        XCTAssertEqual(sut.albumsResults.last?.artistName ?? "", "Drake","Artists Name shouldn't match" )
    }
    
}

