//
//  ViewBackGroundTheme.swift
//  HepsiBuradaFinalProject
//
//  Created by Artun Erol on 30.10.2021.
//

import Foundation
import UIKit

enum ViewBackGroundTheme:GenericValueProtocol {
    typealias Value = UIColor
    
    var value: UIColor {
        switch self{
        case .darkBackground:
            return UIColor(patternImage: UIImage(named: "dark")!)
        case .lighterBackground:
            return UIColor(named: "light")!
        }
    }
    case darkBackground
    case lighterBackground
}
