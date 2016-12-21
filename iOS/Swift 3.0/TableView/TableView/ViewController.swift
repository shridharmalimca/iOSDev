//
//  ViewController.swift
//  TableView
//
//  Created by Shridhar Mali on 12/21/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var arr = ["First","Second", "Third","Fourth","Fifth"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TableView"
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.editClicked))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.addClicked))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    func editClicked() {
        print("editClicked")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClicked))
        self.tblView.setEditing(true, animated: true)
    }

    func doneClicked() {
        print("doneClicked")
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.editClicked))
        self.tblView.setEditing(false, animated: true)
    }

    func addClicked() {
        arr.append("NewElement")
        self.tblView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        return true
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(arr[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arr.remove(at: indexPath.row)
        }
        self.tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
}
