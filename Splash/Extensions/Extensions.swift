//
//  Extensions.swift
//  Splash
//
//  Created by myronishyn.ihor on 07.05.2022.
//

import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
        let windowScenes = connectedScenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        return window
    }
}
