//
//  APIHandler.swift
//  HepsiBuradaFinalProject
//
//  Created by Artun Erol on 30.10.2021.
//

import Foundation

class APIHandler {
    let baseURL = "https://itunes.apple.com/search?limit=20" //Setting content limit of the APIURL to 20
    
    static public let shared = APIHandler()
    
    func getData(productType: String, searchedProductName: String, completion: @escaping (APIResult) -> Void) {
        
        let searchString = searchedProductName.replacingOccurrences(of: " ", with: "+") // If user puts a space between words, change it with + in order to work with the URL.
        guard let url = URL(string: "\(baseURL)&media=\(productType)&term=\(searchString)") else { return } //setting url to make the search with related filter.
        print("url is \(url)")
        let _ = URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            if error == nil { //Error Handling for dataTask
                guard let data = data else { return } // API Data of Custom URL
                do {
                    let decoder = try JSONDecoder().decode(APIResult.self, from: data)
                    print("decoder is\(decoder)")
                    completion(decoder) // Completing the json Decode Operation
                }
                catch {
                    print("Couldn't parse the JSON with error \(error)")
                }
                
            }
            else {
                print("API error is \(String(describing: error))")
            }
        }.resume()
    }
}
