//
//  SongsInteractor.swift
//  JSONParsing
//
//  Created by Shridhar Mali on 12/27/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

protocol SongsInteractorInputDelegate {
    func getItunesSongs()
}

class SongsInteractor: NSObject {
    var delegate: SongsInteractorInputDelegate?
}
extension SongsInteractor: SongsInteractorInputDelegate {
    func getItunesSongs() {
        print("comes here in interactor for request")
        let requestManager = RequestManager(connectionManagerDelegate: self)
        requestManager.requestSongs()
    }
}

extension SongsInteractor: ConnectionManagerDelegate {
    func didReceiveData(response: Any) {
        print(response)
        let presentor = SongsPresentor()
        presentor.presentorDelegate = self as? SongsPresentorInputDelegate
        presentor.showSongs(data: response)
    }
}
