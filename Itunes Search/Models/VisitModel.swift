//
//  VisitModel.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/13/21.
//

import Foundation
import RealmSwift

class VisitModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var dateVisit = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
