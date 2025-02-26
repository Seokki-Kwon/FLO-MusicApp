//
//  SceneDelegate.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/1/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tabBarVC = TabBarViewController()
        
        let chartListVC = ChartListViewController()        
        let chartListNavController = UINavigationController()
        let coverNavController = UINavigationController()
        let searchNavController = UINavigationController()
        let myMusicNavController = UINavigationController()
        
        let coverVC = CoverListViewController()
        let searchVC = SearchViewController()
        let myMusicVC = MyMusicViewController()
        
        chartListNavController.setViewControllers([chartListVC], animated: true)
        coverNavController.setViewControllers([coverVC], animated: true)
        searchNavController.setViewControllers([searchVC], animated: true)
        myMusicNavController.setViewControllers([myMusicVC], animated: true)
        coverNavController.navigationBar.prefersLargeTitles = true
        searchNavController.navigationBar.prefersLargeTitles = true
        myMusicNavController.navigationBar.prefersLargeTitles = true
        
        chartListVC.title = "둘러보기"
        chartListNavController.navigationBar.topItem?.title = "차트"
        coverVC.title = "커버곡"
        searchVC.title = "검색"
        myMusicVC.title = "보관함"
        
        setAppeareance()
        tabBarVC.setViewControllers([chartListNavController, coverNavController, searchNavController, myMusicNavController])
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
    
    func setAppeareance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.black
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

