//
//  TextFonts.swift
//  HepsiBuradaFinalProject
//
//  Created by Artun Erol on 30.10.2021.
//

import Foundation
import UIKit

enum TextFonts: GenericValueProtocol {
    typealias Value = UIFont?
    
    var value: UIFont? {
        switch self {
        case .title(let size): //Custom title FONT
            return UIFont(name: "AppleSDGothicNeo-Bold", size: size)
        case .subTitle(let size): //Custom subTitle Font
            return UIFont(name: "AppleSDGothicNeo-Light", size: size)
        }
    }

    case title(CGFloat)
    case subTitle(CGFloat)
}
