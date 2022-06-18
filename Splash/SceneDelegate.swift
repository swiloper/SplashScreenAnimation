//
//  SceneDelegate.swift
//  Splash
//
//  Created by myronishyn.ihor on 07.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var foregroundWindow: UIWindow!
    private var backgroundWindow: UIWindow!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        showForegroundWindow()
        SplashAnimator.startHeartAnimation()
        showBackgroundWindow()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            SplashAnimator.stopHeartAnimation {
                self.foregroundWindow = nil
                self.backgroundWindow = nil
            }
        }
    }
    
    private func showForegroundWindow() {
        if let keyWindow = window, let keyScene = keyWindow.windowScene {
            foregroundWindow = UIWindow(windowScene: keyScene)
            foregroundWindow.frame = keyWindow.frame
            foregroundWindow.rootViewController = SplashViewController()
            foregroundWindow.windowLevel = .normal + 1
            foregroundWindow.isHidden = false
        }
    }

    private func showBackgroundWindow() {
        if let keyWindow = window, let keyScene = keyWindow.windowScene {
            backgroundWindow = UIWindow(windowScene: keyScene)
            backgroundWindow.frame = keyWindow.frame
            backgroundWindow.backgroundColor = .white
            backgroundWindow.windowLevel = .normal - 1
            backgroundWindow.isHidden = false
        }
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

