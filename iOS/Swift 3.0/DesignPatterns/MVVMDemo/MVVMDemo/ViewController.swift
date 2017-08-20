//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Shridhar Mali on 8/20/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    // Add a Object in storyboard and connect
    @IBOutlet var viewModel: ViewModel!
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fecthSongs {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // Confifure cell
    func configureCell(cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        print("Value is : \(viewModel.titleForRowAtIndexPath(indexPath: indexPath))")
        cell.textLabel?.text = viewModel.titleForRowAtIndexPath(indexPath: indexPath)
    }

}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsAtIndexPath(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        configureCell(cell: cell, forRowAtIndexPath: indexPath)
        return cell
    }
}
