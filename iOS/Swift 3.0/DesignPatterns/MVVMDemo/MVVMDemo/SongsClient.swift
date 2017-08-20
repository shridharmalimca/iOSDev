//
//  SongsClient.swift
//  MVVMDemo
//
//  Created by Shridhar Mali on 8/20/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class SongsClient: NSObject {
    func fetchMovies(completion: @escaping ([NSDictionary]?) -> ()) {
        // Get the data from server 
        let urlString = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
        let url = URL(string: urlString)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                // print("dictionary is:\(json)")
                if let movies = json?.value(forKeyPath: "feed.entry") as? [NSDictionary] {
                    completion(movies)
                }
                
            } catch {
                print("Error while parsing")
            }
            
        }
        task.resume()
        
        // response back in completion
       
    }
}
