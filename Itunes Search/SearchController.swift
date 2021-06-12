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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        trackTableView.delegate = self
        trackTableView.dataSource = self
        trackTableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        loadSearchAPILink()
    }
    
    func loadSearchAPILink() {
        Network.request(URLString: GlobalVariable.searchAPILink) { success, response in
            let trackArray  = (response as! NSDictionary)["results"] as! [[String:Any]]
            self.results.removeAll()
            let realm = try! Realm()
            do {
                try! realm.write {
                    for track in trackArray {
                        let thisResult = result(trackName: track["trackName"] as? String, artworkUrl30: track["artworkUrl30"] as? String, trackPrice: track["trackPrice"] as? Double)
                        self.results.append(thisResult)
                        let thisTrack = TrackModel()
                        thisTrack.artworkUrl30 = thisResult.artworkUrl30 ?? ""
                        thisTrack.trackName = thisResult.trackName ?? ""
                        thisTrack.trackPrice = thisResult.trackPrice ?? 0.00
                        thisTrack.id = GlobalVariable.incrementTrackPrimaryKey()
                        realm.create(TrackModel.self, value: thisTrack, update: .all)
                    }
                }
            } catch {}
            print(realm.configuration.fileURL ?? "")
            
            DispatchQueue.main.async {
                self.trackTableView.reloadData()
            }
        } failed: { failed, response in
            print("failed",response as Any)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trackTableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.update(track: results[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }

}

struct result: Codable {
    var trackName: String?
    var artworkUrl30: String?
    var trackPrice: Double?
}
