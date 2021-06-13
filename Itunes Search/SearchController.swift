//
//  SearchController.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/12/21.
//

import UIKit
import Alamofire
import RealmSwift

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var trackTableView: UITableView!
    var results = [result]()
    let realm = try! Realm()
    var tracks: Results<TrackModel>?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        trackTableView.delegate = self
        trackTableView.dataSource = self
        trackTableView.register(UINib(nibName: "TrackCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
        loadSearchAPILink()
    }
    
    func loadSearchAPILink() {
        Network.request(URLString: GlobalVariable.searchAPILink) { success, response in
            let trackArray  = (response as! NSDictionary)["results"] as! [[String:Any]]
            self.results.removeAll()
            do {
                try! self.realm.write {
                    for track in trackArray {
                        let thisResult = result(trackName: track["trackName"] as? String ?? track["collectionName"] as? String, artworkUrl30: track["artworkUrl60"] as? String, trackPrice: track["trackPrice"] as? Double ?? track["collectionPrice"] as? Double, primaryGenreName: track["primaryGenreName"] as? String, description: track["longDescription"] as? String)
                        self.results.append(thisResult)
                        let thisTrack = TrackModel()
                        thisTrack.artworkUrl30 = thisResult.artworkUrl30 ?? ""
                        thisTrack.trackName = thisResult.trackName ?? ""
                        thisTrack.trackPrice = thisResult.trackPrice ?? 0.00
                        thisTrack.genre = thisResult.primaryGenreName ?? ""
                        thisTrack.longDescription =  thisResult.description ?? ""
                        thisTrack.id = GlobalVariable.incrementTrackPrimaryKey()
                        if !self.trackExist(thisTrack: thisTrack) {
                            self.realm.create(TrackModel.self, value: thisTrack, update: .all)
                        }
                    }
                }
            } catch {}
            print(self.realm.configuration.fileURL ?? "")
            
            DispatchQueue.main.async {
                self.tracks = try! Realm().objects(TrackModel.self)
                self.trackTableView.reloadData()
            }
        } failed: { failed, response in
            print("failed",response as Any)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trackTableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        cell.update(track: tracks![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailController()
        detailController.title = tracks?[indexPath.row].trackName
        detailController.track = (tracks?[indexPath.row])!
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func trackExist(thisTrack: TrackModel) -> Bool {
        let checkTrack = try! Realm().objects(TrackModel.self).filter("artworkUrl30 == '\(thisTrack.artworkUrl30)'")
        if checkTrack.count > 0 {
            return true
        } else {
            return false
        }
    }

}

struct result: Codable {
    var trackName: String?
    var artworkUrl30: String?
    var trackPrice: Double?
    var primaryGenreName: String?
    var description: String?
}
