//
//  AppDelegate.swift
//  GreekDictionary
//
//  Created by Grigorii Metelev on 30.03.2022.
//

import UIKit
import SQLite

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let vocabulary = Vocabulary()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.


        guard let dbPath = Bundle.main.path(forResource: "dvoretsky_greek", ofType: "db") else {
            fatalError()
        }

        do {
            let db = try Connection(dbPath)

            let hash = Expression<Int>("hash")
            let title = Expression<String>("title")
            let entry = Expression<String>("entry")

            try Letter.Letters.allCases.forEach {
                let table = Table($0.rawValue)

                for word in try db.prepare(table) {
                    AppDelegate.vocabulary.populate(letter: $0, hash: word[hash], value: word[title], entry: word[entry])
                }
            }

            print("Finished")

        } catch {
            fatalError(error.localizedDescription)
        }

        return true
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

