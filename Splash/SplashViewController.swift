//
//  ViewController.swift
//  Splash
//
//  Created by myronishyn.ihor on 07.05.2022.
//

import UIKit

final class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(SplashAnimator.blackgroundView)
        view.addSubview(SplashAnimator.heartImageView)
    }
}
