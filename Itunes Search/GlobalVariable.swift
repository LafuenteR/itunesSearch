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
    
    static var search = "Search"
    static var favorite = "Favorite"
    static var home = "Home"
    
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
    
    static func incrementVisitPrimaryKey() -> Int {
        let realm = try! Realm()
        let visits = realm.objects(VisitModel.self)
        if visits.count > 0 {
            let lastID = visits.last?.id
            return lastID! + 1
        } else {
            return 0
        }
    }
    
    static func incrementVisitPagePrimaryKey() -> Int {
        let realm = try! Realm()
        let visits = realm.objects(LastVisitPageModel.self)
        if visits.count > 0 {
            let lastID = visits.last?.id
            return lastID! + 1
        } else {
            return 0
        }
    }

}
