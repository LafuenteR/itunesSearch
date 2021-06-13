//
//  TrackCell.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/13/21.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var artworkUrl30: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(track: TrackModel) {
        trackNameLabel.text = track.trackName
        genreLabel.text = track.genre
        priceLabel.text = "$ \(track.trackPrice )"
        let url = URL(string: track.artworkUrl30 )
        artworkUrl30.contentMode = .scaleAspectFill
        artworkUrl30.kf.setImage(with: url)
    }
    
}
