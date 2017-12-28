//
//  ViewController.swift
//  JSONParsing
//
//  Created by Shridhar Mali on 12/27/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
protocol SongsViewControllerInputDelegate: class {
    func presentSongs(response: SongsViewModel)
}
class SongsViewController: UIViewController {
    weak var presentor: SongsViewControllerInputDelegate?
    let router = SongsRouter()
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextClicked))
        router.routerDelegate = self as? SongsRouterDelegate
    }
    
    @objc func nextClicked() {
        print("nextClicked")
        self.performSegue(withIdentifier: "details", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            router.natigateToScene(segue)
        }
    }
}

extension SongsViewController: SongsViewControllerInputDelegate {
    func presentSongs(response: SongsViewModel) {
        print(response.feed.results.count)
        self.songResults = response.feed.results
        //self.tblSongs.reloadData()
    }
}

extension SongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = self.songResults[indexPath.row].name
        cell?.detailTextLabel?.text = self.songResults[indexPath.row].artistName
        return cell!
    }
}


