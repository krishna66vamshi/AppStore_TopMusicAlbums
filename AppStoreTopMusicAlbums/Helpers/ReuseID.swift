//
//  UITableViewCell+ReuseID.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 17/08/24.
//

import UIKit

extension UITableViewCell{
    static var reuseID:String{
       return String(describing: self)
    }
}

extension UIViewController{
    static var reuseID:String{
       return String(describing: self)
    }
}
