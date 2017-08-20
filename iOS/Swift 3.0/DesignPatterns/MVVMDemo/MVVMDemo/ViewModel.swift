//
//  ViewModel.swift
//  MVVMDemo
//
//  Created by Shridhar Mali on 8/20/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    
    @IBOutlet var songsClient: SongsClient!
    // var movies: [String: Any]? = [String: Any]()
    var movies: [NSDictionary]?
    func fecthSongs(completion: @escaping () -> () ) {
        songsClient.fetchMovies{ movie in
            self.movies =  movie
            print("movies are \(self.movies)")
            completion()
        }
    }

    func numberOfRowsAtIndexPath(section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func titleForRowAtIndexPath(indexPath: IndexPath) -> String {
        //print(self.movies.removeValue(forKey: "i"))
        print(movies?[indexPath.row].value(forKeyPath: "im:name.label"))
        return movies?[indexPath.row].value(forKeyPath: "im:name.label") as! String
    }
}
