//
//  SongsPresentor.swift
//  JSONParsing
//
//  Created by Shridhar Mali on 12/27/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

protocol SongsPresentorInputDelegate {
    func showSongs(data: Any)
}

class SongsPresentor: NSObject {
    var presentorDelegate: SongsPresentorInputDelegate?
}

extension SongsPresentor: SongsPresentorInputDelegate {
    func showSongs(data: Any) {
        let songs = data as! SongsViewModel
        print(songs.feed.results[0].name)
        let viewController = SongsViewController()
        viewController.presentor = self as? SongsViewControllerInputDelegate
        viewController.presentSongs(response: songs)
    }
}
