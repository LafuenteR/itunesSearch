//
//  SearchController.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/12/21.
//

import UIKit
import Alamofire
import RealmSwift

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var trackTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var results = [result]()
    let realm = try! Realm()
    var tracks: Results<TrackModel>?
    var visits: Results<VisitModel>?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = GlobalVariable.search
        trackTableView.delegate = self
        trackTableView.dataSource = self
        searchBar.delegate = self
        trackTableView.register(UINib(nibName: "TrackCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
        lastVisit()
        loadSearchAPILink()
    }
    
    func lastVisit() {
        let thisVisit = VisitModel()
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MMM d, yyyy h:mm a"
        let thisDate = dateformat.string(from: Date())
        try! self.realm.write {
            thisVisit.dateVisit = thisDate
            thisVisit.id = GlobalVariable.incrementVisitPrimaryKey()
            self.realm.create(VisitModel.self, value: thisVisit, update: .all)
        }
    }
    
    func loadSearchAPILink() {
        Network.request(URLString: GlobalVariable.searchAPILink) { success, response in
            if success! {
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
            }
            
        } failed: { failed, response in
            print("failed",response as Any)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.visits = try! Realm().objects(VisitModel.self)
            self.tracks = try! Realm().objects(TrackModel.self)
            self.trackTableView.reloadData()
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
        detailController.track = (tracks?[indexPath.row])!
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: 300, height: 20))
        if visits!.count > 1 {
            label.text = "Last Visited: \(visits![visits!.count - 2].dateVisit)"
        }
        label.textColor = .black
        view.addSubview(label)
        view.backgroundColor = .systemGray5
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.0
        if visits?.count ?? 0 > 1 {
            return 30.0
        } else {
            return 0.0
        }
    }
    
    func trackExist(thisTrack: TrackModel) -> Bool {
        let checkTrack = try! Realm().objects(TrackModel.self).filter("artworkUrl30 == '\(thisTrack.artworkUrl30)'")
        if checkTrack.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
            if searchText.count > 0 {
                let query = NSPredicate(format:"trackName CONTAINS %@", searchText)
                self.tracks = try! Realm().objects(TrackModel.self).filter(query)
                self.trackTableView.reloadData()
            } else {
                self.tracks = try! Realm().objects(TrackModel.self)
                self.trackTableView.reloadData()
            }
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
