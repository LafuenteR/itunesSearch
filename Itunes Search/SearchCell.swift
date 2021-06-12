//
//  SearchCell.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/12/21.
//

import UIKit
import Kingfisher

class SearchCell: UITableViewCell {

    @IBOutlet weak var artworkUrl30: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(track: result) {
        trackNameLabel.text = track.trackName ?? "Track"
        priceLabel.text = "$ \(track.trackPrice ?? 0.00)"
        let url = URL(string: track.artworkUrl30 ?? "")
        artworkUrl30.contentMode = .scaleAspectFill
        artworkUrl30.kf.setImage(with: url)
    }
    
}
