//
//  DetailedViewController.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import UIKit
import SafariServices


class DetailedViewController: UIViewController {
    @IBOutlet weak var artistImgView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var viewArtistDetails: UIButton!

    
    var feedVM:FeedViewModel?
    var artistsDetailsVM:ArtistDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
    }
    
    func setupViewModel(){
        if let feedVM = feedVM{
           artistsDetailsVM = ArtistDetailsViewModel(feedViewModel: feedVM,webServices: NetworkManager())
        }
    }
    
    func setupUI(){
        viewArtistDetails.layer.cornerRadius = 20
        if let feedVM = feedVM{
            self.title = feedVM.artistName
            artistName.text = "Artist Name : " + feedVM.artistName
            releaseDate.text = "Album Release Date : " + feedVM.releaseDate
            albumName.text = "Album Name : " + feedVM.artistName
            loadImage()
        }
    }
    
    func loadImage(){
        Task{
            if let image = await artistsDetailsVM.downloadImageFromCache(imageUrl: feedVM?.artworkUrl100 ?? ""){
                self.artistImgView.image = image
            }else{
                self.artistImgView.image = UIImage(named: "placeholder")
            }
        }
    }
    
    @IBAction func viewArtistsDetails(_ sender: Any) {
        if let feedVM = feedVM{
            if let url = URL(string: feedVM.artistURL) {
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true, completion: nil)
            }
        }
    }
    
    
}
