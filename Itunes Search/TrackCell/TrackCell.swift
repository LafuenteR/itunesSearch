//
//  TrackCell.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/13/21.
//

import UIKit
import RealmSwift

class TrackCell: UITableViewCell {

    @IBOutlet weak var artworkUrl30: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var faveButtonUI: UIButton!
    let realm = try! Realm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func updateFaveButton(_ sender: Any) {
        let tag = (sender as! UIButton).tag
        let thisTrack = try! Realm().objects(TrackModel.self).filter("id == \(tag)")
        
        if thisTrack.count > 0 {
            if thisTrack.first!.isFavorite {
                try! realm.write {
                    thisTrack.first!.isFavorite = false
                }
                faveButtonUI.setImage(UIImage(systemName: "star"), for: .normal)
            } else {
                try! realm.write {
                    thisTrack.first!.isFavorite = true
                }
                faveButtonUI.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Updating the cell
    func update(track: TrackModel) {
        trackNameLabel.text = track.trackName
        faveButtonUI.tag = track.id
        genreLabel.text = track.genre
        if track.isFavorite {
            faveButtonUI.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            faveButtonUI.setImage(UIImage(systemName: "star"), for: .normal)
        }
        priceLabel.text = "$ \(track.trackPrice )"
        let url = URL(string: track.artworkUrl30 )
        artworkUrl30.contentMode = .scaleAspectFill
        artworkUrl30.kf.setImage(with: url)
    }
    
}
