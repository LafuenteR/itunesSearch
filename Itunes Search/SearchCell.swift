//
//  SearchCell.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/12/21.
//

import UIKit

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
    
}
