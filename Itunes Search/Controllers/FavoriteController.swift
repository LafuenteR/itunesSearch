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
    let realm = try! Realm()
    var lastVisitPage: Results<LastVisitPageModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = GlobalVariable.favorite
        checkLastVisitPage()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(UINib(nibName: "TrackCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lastVisitPage(tabName: GlobalVariable.favorite, pageName: GlobalVariable.home)
        favorites = try! Realm().objects(TrackModel.self).filter("isFavorite == \(true)")
        self.favoriteTableView.reloadData()
    }
    
    // Checking the Last Visit Page before closing the app.
    func checkLastVisitPage() {
        lastVisitPage = try! Realm().objects(LastVisitPageModel.self)
        if lastVisitPage?.count ?? 0 > 1 {
            let thisPage = lastVisitPage![lastVisitPage!.count - 1]
            if thisPage.tabName == GlobalVariable.favorite && thisPage.pageName != GlobalVariable.home {
                let id = (thisPage.pageName as NSString).integerValue
                let thisTrack = try! Realm().objects(TrackModel.self).filter("id == \(id)")
                let detailController = DetailController()
                detailController.track = thisTrack.first
                lastVisitPage(tabName: GlobalVariable.favorite, pageName: "\(thisTrack.first?.id)")
                navigationController?.pushViewController(detailController, animated: true)
            }
        }
    }
    
    // Function use for saving the current page to LastVisitPageModel
    func lastVisitPage(tabName: String, pageName: String) {
        let thisPage = LastVisitPageModel()
        try! self.realm.write {
            thisPage.tabName = tabName
            thisPage.id = GlobalVariable.incrementVisitPagePrimaryKey()
            thisPage.pageName = pageName
            self.realm.create(LastVisitPageModel.self, value: thisPage, update: .all)
        }
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
    
    // Reload the Favorites TableView
    @objc func reloadFavorites() {
        self.favoriteTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailController()
        detailController.track = (favorites?[indexPath.row])!
        lastVisitPage(tabName: GlobalVariable.favorite, pageName: "\(favorites![indexPath.row].id)")
        navigationController?.pushViewController(detailController, animated: true)
    }

}
