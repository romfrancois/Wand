//
//  Spells.swift
//  Wand
//
//  Created by Romain Francois on 19/07/2020.
//  Copyright © 2020 Romain Francois. All rights reserved.
//

import Foundation

class Spells {
    var spellArray: [SpellData] = []
    var urlString: String = "https://potterspells.herokuapp.com/api/v1/spells"
    
    private struct Results: Codable {
        var results: [SpellData]
    }
    
    func getData(completed: @escaping () -> ()) {
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("ERROR: Couldn't create a URL from \(urlString)")
            completed()
            return
        }
        
        // Create session
        let session = URLSession.shared
        
        // get data with .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            
            // deal with the data
            do {
                let results = try JSONDecoder().decode(Results.self, from: data!)
                self.spellArray = results.results
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        
        task.resume()
    }
}
