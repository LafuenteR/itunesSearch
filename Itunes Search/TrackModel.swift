//
//  TrackModel.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/13/21.
//

import Foundation
import RealmSwift

class TrackModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var trackName = ""
    @objc dynamic var artworkUrl30 = ""
    @objc dynamic var trackPrice = 0.00
    @objc dynamic var genre = ""
    @objc dynamic var isFavorite = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
