//
//  ViewController.swift
//  iPhonePopOver
//
//  Created by Shridhar Mali on 2/15/18.
//  Copyright © 2018 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var tblView: UITableView!
    var indexpath = IndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "popOver", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pop" {
            //UITableviewcells btn popover
            if let popOverVC = segue.destination as? PopOverViewController {
                popOverVC.modalPresentationStyle = .popover
                let popover = popOverVC.popoverPresentationController!
                popover.delegate = self
                popover.permittedArrowDirections = .up
                
                let rectOfCell = tblView.rectForRow(at: indexpath)
                let cellRectConvertAsPerViewController = tblView.convert(rectOfCell, to: self.view)
                popover.sourceRect = cellRectConvertAsPerViewController
            }
            
        } else {
            //simple popover in viewcontroller
            if let popOverVC = segue.destination as? PopOverViewController {
                popOverVC.modalPresentationStyle = .popover
                let popover = popOverVC.popoverPresentationController!
                popover.delegate = self
                popover.permittedArrowDirections = .up
                let but  = sender as! UIButton
                popover.sourceRect = but.bounds
            }
        }
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.dismissalTransitionDidEnd(true)
    }
    
    @objc func popOverClicked(_ sender: UIButton) {
            indexpath = IndexPath(row: sender.tag, section: 0)
            self.performSegue(withIdentifier: "pop", sender: sender)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PopOverTableViewCell
        cell.popOverBtn.tag = indexPath.row
        cell.popOverBtn.addTarget(self, action: #selector(popOverClicked(_:)), for: .touchUpInside)
        return cell
    }
    
}
