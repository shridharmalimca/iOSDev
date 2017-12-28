//
//  ConnectionManager.swift
//  JSONParsing
//
//  Created by Shridhar Mali on 12/28/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import Foundation
protocol ConnectionManagerDelegate {
    func didReceiveData(response: Any)
}

struct RequestManager {
    let serverBaseUrl = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/50/explicit.json")
    let connectionManagerDelegate: ConnectionManagerDelegate!
    func requestSongs() {
        let urlRequest = URLRequest(url: serverBaseUrl!)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let responseData = data else {
                return
            }
            let decoder = JSONDecoder()
            do {
                let newJSON = try decoder.decode(SongsViewModel.self, from: responseData)
                print(newJSON.feed.results.count)
                self.connectionManagerDelegate.didReceiveData(response: newJSON)
            } catch let e {
                print("error while parsing JSON \(e.localizedDescription)")
            }
        }
        task.resume()
    }
}
