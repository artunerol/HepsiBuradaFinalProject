//
//  DidSelectCellProtocol.swift
//  HepsiBuradaFinalProject
//
//  Created by Artun Erol on 31.10.2021.
//

import Foundation

protocol DidSelectCellProtocol: AnyObject {
    func setTitle(title:String)
    func setReleaseDate(date:String)
    func setImage(imageURL: String)
}
