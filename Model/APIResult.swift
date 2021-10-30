//
//  APIResult.swift
//  HepsiBuradaFinalProject
//
//  Created by Artun Erol on 30.10.2021.
//

import Foundation

struct APIResult: Codable {
    let resultCount: Int
    let results: [APIResultKeys]
}

