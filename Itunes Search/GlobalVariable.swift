//
//  GlobalVariable.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/12/21.
//

import Foundation
import RealmSwift

struct GlobalVariable {
    
    static var searchAPILink = "https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp;all"
    
    static func incrementTrackPrimaryKey() -> Int {
        let realm = try! Realm()
        let tracks = realm.objects(TrackModel.self)
        if tracks.count > 0 {
            let lastID = tracks.last?.id
            return lastID! + 1
        } else {
            return 0
        }
    }

}
