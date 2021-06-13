//
//  AppDelegate.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/12/21.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = Realm.Configuration (
            
            schemaVersion: 1,
            
            migrationBlock: { migration, oldSchemaVersion in
                
                if (oldSchemaVersion < 1) {
                    
                }
            })
        
        Realm.Configuration.defaultConfiguration = config
        
        lastVisit()
        
        return true
    }
    
    func lastVisit() {
        let realm = try! Realm()
        let thisVisit = VisitModel()
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MMM d, yyyy h:mm a"
        let thisDate = dateformat.string(from: Date())
        try! realm.write {
            thisVisit.dateVisit = thisDate
            thisVisit.id = GlobalVariable.incrementVisitPrimaryKey()
            realm.create(VisitModel.self, value: thisVisit, update: .all)
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

