//
//  LastVisitPageModel.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/13/21.
//

import Foundation
import RealmSwift

class LastVisitPageModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var tabName = ""
    @objc dynamic var pageName = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
