//
//  APIDataModel.swift
//  HepsiBuradaFinalProject
//
//  Created by Artun Erol on 30.10.2021.
//

import UIKit

struct APIResultKeys: Codable {
    
    let artworkUrl100: String?
    let collectionPrice: Double?
    let collectionName: String?
    let releaseDate: String?
    let trackName: String? //Name Result of the current search

}
