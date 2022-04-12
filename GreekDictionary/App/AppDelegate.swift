//
//  AppDelegate.swift
//  GreekDictionary
//
//  Created by Grigorii Metelev on 30.03.2022.
//

import UIKit
import SQLite

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initializeDB()
        return true
    }
}

// MARK: - Private
private extension AppDelegate {
    func initializeDB() {
        guard let dbPath = Bundle.main.path(forResource: "dvoretsky_greek", ofType: "db") else {
            fatalError("No such db")
        }

        do {
            try Vocabulary.shared.seed(with: dbPath)
            print("Finished")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
