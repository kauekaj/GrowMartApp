//
//  AppDelegate.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 22/08/22.
//

import UIKit
import FirebaseCore
import FirebaseRemoteConfig

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var coreDataStack: CoreDataStack = .init(modelName: "Favorites")
    lazy var remoteConfig = RemoteConfig.remoteConfig()
    
    static let sharedAppDelegate: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unexpected app delegate type, did it change? \(String(describing: UIApplication.shared.delegate))")
        }
        return delegate
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        fetchRemoteConfig()
        setupNavigation()
        DataManager.shared.setup(source: .realm)
        
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
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return
    }
    
}

// MARK: - Private Methods

extension AppDelegate {
    
    private func fetchRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activate { changed, error in
                    // ...
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
    
    private func setupNavigation() {
        let backIndicatorImage = Asset.Images.arrow.image.withRenderingMode(.alwaysOriginal)
        let barAppearance = UINavigationBar.appearance()
        barAppearance.backIndicatorImage = backIndicatorImage
        barAppearance.backIndicatorImage?.withTintColor(.black)
        barAppearance.backIndicatorTransitionMaskImage = backIndicatorImage
    }
}
