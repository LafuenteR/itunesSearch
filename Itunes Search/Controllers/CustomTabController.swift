//
//  CustomTabController.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/13/21.
//

import UIKit
import RealmSwift

class CustomTabController: UITabBarController {
    
    let realm = try! Realm()
    var lastVisitPage: Results<LastVisitPageModel>?

    override func viewDidLoad() {
        super.viewDidLoad()
        lastVisitPage = try! Realm().objects(LastVisitPageModel.self)
        
        if lastVisitPage?.count ?? 0 > 1 {
            let thisPage = lastVisitPage![lastVisitPage!.count - 1]
            if thisPage.tabName == GlobalVariable.search && thisPage.pageName == GlobalVariable.home {
                self.selectedIndex = 0
            } else if thisPage.tabName == GlobalVariable.search && thisPage.pageName != GlobalVariable.home {
                self.selectedIndex = 0
            } else if thisPage.tabName == GlobalVariable.favorite && thisPage.pageName == GlobalVariable.home {
                self.selectedIndex = 1
            } else if thisPage.tabName == GlobalVariable.favorite && thisPage.pageName != GlobalVariable.home {
                self.selectedIndex = 1
            }
        } else {
            self.selectedIndex = 0
        }
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
