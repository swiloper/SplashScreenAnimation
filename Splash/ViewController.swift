//
//  ViewController.swift
//  Splash
//
//  Created by myronishyn.ihor on 07.05.2022.
//

import UIKit

class ViewController: UIViewController {
    private var backgroundWindow: UIWindow!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBackgroundWindow()
        SplashAnimator.animateAppearance()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            SplashAnimator.animateDisappearance {
                self.backgroundWindow = nil
            }
        }
    }
    
    private func addBackgroundWindow() {
        if let keyWindow = UIApplication.shared.keyWindow, let keyScene = keyWindow.windowScene {
            backgroundWindow = UIWindow(windowScene: keyScene)
            backgroundWindow.frame = keyWindow.frame
            backgroundWindow.backgroundColor = .white
            backgroundWindow.windowLevel = .normal - 1
            backgroundWindow.isHidden = false
        }
    }
}
