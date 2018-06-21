//
//  ProgressHud.swift
// 
//
//  Copyright © 2018 . All rights reserved.
//

import UIKit
import Lottie

class ProgressHud: NSObject {
    static var shared = ProgressHud()
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    let animationView = LOTAnimationView(name: "LottieAnimation")
    
    override init() {
        super.init()

        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        
        container.frame = (UIApplication.shared.keyWindow?.frame)!
        container.center = (UIApplication.shared.keyWindow?.center)!
        container.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadingView.center = (UIApplication.shared.keyWindow?.center)!
        loadingView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        animationView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0);
        loadingView.addSubview(animationView)
        
        container.addSubview(loadingView)
        
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(container)
        animationView.play()
    }
    
    func hide() {
        container.removeFromSuperview()
         animationView.stop()
    }
}
