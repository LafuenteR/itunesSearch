//
//  FavoriteController.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/12/21.
//

import UIKit
import RealmSwift

class FavoriteController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favoriteTableView: UITableView!
    var favorites: Results<TrackModel>?
    var results = [result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(UINib(nibName: "TrackCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
        // Do any additional setup after loading the view.
//        let config = Realm.Configuration(objectTypes: [TrackModel.self])
//        let realm = try! Realm(configuration: config)
        
        let hey = try! Realm().objects(TrackModel.self).filter("isFavorite == \(true)")
        print("dbgbf",hey.count)
        favorites = hey
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        cell.update(track: favorites![indexPath.row])
        return cell
    }

}
