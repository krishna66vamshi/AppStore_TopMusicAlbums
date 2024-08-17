//
//  AlbumTableViewCell.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artistImgView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumReleaseDate: UILabel!

    
    var feed:FeedViewModel?
    var callBack:()->() = {}
    
    func configureCell(feed:FeedViewModel){
        self.feed = feed
        artistName.text = feed.artistName
        albumReleaseDate.text = "Release Date : " + feed.releaseDate
    }
    
    func loadImage(vm:FeedListViewModel){
        Task{
            self.artistImgView.layer.cornerRadius = 15
            if let image = await vm.downloadImageFromCache(imageUrl: feed?.artworkUrl100 ?? ""){
                self.artistImgView.image = image
            }else{
                self.artistImgView.image = UIImage(named: "placeholder")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func openArtistProfileBtnTapped(_ sender: Any) {
        callBack()
    }
}
