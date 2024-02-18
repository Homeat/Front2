//
//  SceneDelegate.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
        // 윈도우의 씬을 가져온다.
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 윈도우의 크기 설정
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainTC = MainTabBarController()
        let navigationController = UINavigationController(rootViewController: RegisterSelectViewController())
        
        // 토근 만료 시간을 조회하고 첫 페이지 뭘 띄울지 결정하는 부분
        let expirationDateString = UserDefaults.standard.string(forKey: "loginTokenExpired") ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let expirationDate = dateFormatter.date(from: expirationDateString) {
            // 현재 시간 가져오기
            let currentDate = Date()

            // 현재 시간과 만료 시간 비교
            if currentDate > expirationDate{
                print("토큰이 만료되었습니다.")
                window?.rootViewController = navigationController
                
            } else {
                window?.rootViewController = mainTC
                print("토큰이 아직 유효합니다.")
            }
        } else {
            window?.rootViewController = navigationController
            print("잘못된 날짜 형식입니다.")
        }

        
        
        // 설정한 윈도우를 보이게끔 설정
        window?.makeKeyAndVisible()
        
        // 윈도우 씬 설정
        window?.windowScene = windowScene
        
        
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
