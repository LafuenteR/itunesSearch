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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.text = track?.longDescription
        let imageURL = URL(string: track?.artworkUrl30 ?? "" )
        trackImage.contentMode = .scaleAspectFill
        trackImage.kf.setImage(with: imageURL)
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
