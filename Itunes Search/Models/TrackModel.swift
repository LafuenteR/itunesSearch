//
//  TrackModel.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/13/21.
//

import Foundation
import RealmSwift

class TrackModel: Object {
    @objc dynamic var id = Int()
    @objc dynamic var trackName = String()
    @objc dynamic var artworkUrl30 = String()
    @objc dynamic var trackPrice = 0.00
    @objc dynamic var genre = String()
    @objc dynamic var longDescription = String()
    @objc dynamic var isFavorite = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
