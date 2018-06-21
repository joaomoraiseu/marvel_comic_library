//
//  HomeViewController.swift
//  Marvel Comic Library
//
//  Created by João  Pedro on 20/06/18.
//  Copyright © 2018 João  Pedro. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func site_action(){
        guard let url = URL(string: "http://marvel.com") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
