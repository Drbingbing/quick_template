//
//  AppDelegate.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/6/27.
//

import UIKit
import UIComponent

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIViewController.doBadSwizzleStuff()
        
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.qt_body(size: 22).bolded]
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.qt_title.bolded]
        
        TappableViewConfiguration.default = TappableViewConfiguration(
            onHighlightChanged: { view, isHighlighted in
                let scale: CGFloat = isHighlighted ? 0.95 : 1.0 / 0.95
                UIView.animate(withDuration: 0.2) {
                    view.transform = view.transform.scaledBy(x: scale, y: scale)
                }
            }
        )
        
        UIComponent.TappableViewConfiguration.default = UIComponent.TappableViewConfiguration(
            onHighlightChanged: { view, isHighlighted in
                let scale: CGFloat = isHighlighted ? 0.96 : 1
                UIView.animate(withDuration: 0.2) {
                    view.transform = .identity.scaledBy(x: scale, y: scale)
                }
            }
        )
        
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

