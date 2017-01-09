//
//  ViewController.swift
//  OperationQueue
//
//  Created by Shridhar Mali on 1/3/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var operationQueue = OperationQueue()
    var queue = DispatchQueue.main
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // blockOperationTest1()
        dispatchQueueTest1()
    }
    func blockOperationTest1() {
        let operation1: BlockOperation = BlockOperation {
            self.doCalculation()
            let operation2: BlockOperation = BlockOperation {
                self.doMoreCalculation()
            }
            self.operationQueue.addOperation(operation2)
        }
        operationQueue.addOperation(operation1)
    }
    func doCalculation() {
        print("doCalculation")
        for i in 0..<5 {
            print(i)
        }
        // sleep(1)
    }
    
    func doMoreCalculation() {
        print("doMoreCalculation")
        for i in 0..<10 {
            print(i)
        }
    }
    
    func dispatchQueueTest1() {
        queue.async {
            self.doCalculation()
            self.queue.async {
                self.doMoreCalculation()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

