//
//  DetailController.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/13/21.
//

import UIKit
import Kingfisher

class DetailController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    var track: TrackModel?
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.text = track?.longDescription != "" ? track?.longDescription : "No Description."
        let imageURL = URL(string: track?.artworkUrl30 ?? "" )
        trackImage.contentMode = .scaleAspectFill
        trackImage.kf.setImage(with: imageURL)
        trackNameLabel.text = track?.trackName
        genreLabel.text = track?.genre
        priceLabel.text = "$ \(track!.trackPrice)"
        // Do any additional setup after loading the view.
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
