//
//  ViewController.swift
//  JSONParsing
//
//  Created by Shridhar Mali on 12/27/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
protocol SongsViewControllerInputDelegate {
    func presentSongs(response: SongsViewModel)
}
class SongsViewController: UIViewController {
    var presentor: SongsViewControllerInputDelegate?
     @IBOutlet weak var tblSongs: UITableView!
    var songResults: [Results] = [Results]()  {
        didSet {
            if let tbl = tblSongs {
                tbl.reloadData()
            } else {
                print("Found nil here")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let interactor = SongsInteractor()
        interactor.delegate = self as? SongsInteractorInputDelegate
        interactor.getItunesSongs()
    }
}

extension SongsViewController: SongsViewControllerInputDelegate {
    func presentSongs(response: SongsViewModel) {
        print(response.feed.results.count)
        songResults = response.feed.results
        tblSongs.reloadData()
    }
}

extension SongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = songResults[indexPath.row].name
        cell?.detailTextLabel?.text = songResults[indexPath.row].artistName
        return cell!
    }
}
