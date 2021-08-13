//
//  LastVisitPageModel.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/13/21.
//

import Foundation
import RealmSwift

class LastVisitPageModel: Object {
    @objc dynamic var id = Int()
    @objc dynamic var tabName = String()
    @objc dynamic var pageName = String()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
