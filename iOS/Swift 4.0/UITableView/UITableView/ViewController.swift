//
//  ViewController.swift
//  UITableView
//
//  Created by Shridhar Mali on 12/28/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var arrOfNames = ["FirstName", "SecondName", "ThirdName", "FourthName"]
    var arrOfAge: [Int] = [10, 20, 30, 40]
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func btnClicked(sender: UIButton) {
        print(sender.tag)
        let storyboard = UIStoryboard(name: "DetailStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.name = arrOfNames[sender.tag]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.titleLbl.text = arrOfNames[indexPath.row]
        cell.detailLbl.text = String(describing: arrOfAge[indexPath.row])
        cell.imgView.image = UIImage(named: "PlusButtonForInnerEng")
        cell.btn.tag = indexPath.row
        cell.btn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
