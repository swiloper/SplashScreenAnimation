//
//  Launch.swift
//  Splash
//
//  Created by myronishyn.ihor on 07.05.2022.
//

import UIKit

protocol SplashAnimatorProtocol: AnyObject {
    func animateAppearance()
    func animateDisappearance(completion: @escaping () -> Void)
}

final class SplashAnimator {
    
    // MARK: Properties
    
    private static var screenBounds = UIScreen.main.bounds
    
    private static let blackgroundView: UIView = {
        let view = UIView(frame: screenBounds)
        view.backgroundColor = .white
        let test = UIActivityIndicatorView()
        test.startAnimating()
        return view
    }()

    private static let heartImageView: UIImageView = {
        let imageViewSide: CGFloat = 120.0
        let imageView = UIImageView(frame: CGRect(x: (screenBounds.width - imageViewSide) / 2, y: (screenBounds.height - imageViewSide) / 2, width: imageViewSide, height: imageViewSide))
        imageView.image = UIImage(named: "heart")
        return imageView
    }()
    
    // MARK: Methods
    
    private static func startHeartAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0.5, options: [.autoreverse, .repeat]) {
            heartImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    static func animateAppearance() {
        if let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.addSubview(blackgroundView)
            keyWindow.addSubview(heartImageView)
            startHeartAnimation()
        }
    }
    
    static func animateDisappearance(completion: @escaping () -> Void) {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        blackgroundView.removeFromSuperview()
        heartImageView.removeFromSuperview()
        
        let mask = CALayer()
        let imageViewSide: CGFloat = 120.0
        mask.frame = CGRect(x: (screenBounds.width - imageViewSide) / 2, y: (screenBounds.height - imageViewSide) / 2, width: imageViewSide, height: imageViewSide)
        mask.contents = heartImageView.image?.cgImage
        keyWindow.layer.mask = mask
        
        let maskBackgroundView = UIImageView(image: heartImageView.image)
        maskBackgroundView.frame = mask.frame
        keyWindow.addSubview(maskBackgroundView)
        keyWindow.bringSubviewToFront(maskBackgroundView)
        
        CATransaction.setCompletionBlock {
            keyWindow.layer.mask = nil
            completion()
        }
        
        CATransaction.begin()
        
        keyWindow.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        UIView.animate(withDuration: 0.6, animations: {
            keyWindow.transform = .identity
        })
        
        [mask, maskBackgroundView.layer].forEach { layer in
            addScalingAnimation(to: layer, duration: 0.6)
        }
        
        UIView.animate(withDuration: 0.1, delay: 0.1) {
            maskBackgroundView.alpha = 0
        } completion: { _ in
            maskBackgroundView.removeFromSuperview()
        }
        
        CATransaction.commit()
    }
    
    private static func addScalingAnimation(to layer: CALayer, duration: TimeInterval, delay: CFTimeInterval = 0) {
        let animation = CAKeyframeAnimation(keyPath: "bounds")
        
        let width = layer.frame.size.width
        let height = layer.frame.size.height
        let coeficient: CGFloat = 18 / 667
        let finalScale = UIScreen.main.bounds.height * coeficient
        let scales = [1, 0.85, finalScale]
        
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.keyTimes = [0, 0.2, 1]
        animation.values = scales.map { NSValue(cgRect: CGRect(x: 0, y: 0, width: width * $0, height: height * $0)) }
        animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
                                     CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        layer.add(animation, forKey: "scaling")
    }
}
