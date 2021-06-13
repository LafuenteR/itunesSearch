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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = GlobalVariable.favorite
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(UINib(nibName: "TrackCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favorites = try! Realm().objects(TrackModel.self).filter("isFavorite == \(true)")
        self.favoriteTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        cell.update(track: favorites![indexPath.row])
        cell.faveButtonUI.addTarget(self, action: #selector(reloadFavorites), for: .touchUpInside)
        return cell
    }
    
    @objc func reloadFavorites() {
        self.favoriteTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailController()
        detailController.track = (favorites?[indexPath.row])!
        navigationController?.pushViewController(detailController, animated: true)
    }

}
