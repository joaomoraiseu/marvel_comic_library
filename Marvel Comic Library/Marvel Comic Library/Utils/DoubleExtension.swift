//
//  DoubleExtension.swift
//  
//
//  Created by João  Pedro on 20/06/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
