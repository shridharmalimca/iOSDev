//
//  ViewController.swift
//  JSONParsing
//
//  Created by Shridhar Mali on 12/31/16.
//  Copyright © 2016 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var arr = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromServer()
        self.tblView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Get all json data from following URL
    // http://www.apple.com/rss/
    
    func getDataFromServer() {
        let urlString: String = "https://itunes.apple.com/us/rss/topsongs/limit=100/json"
        let url = URL(string: urlString)
        //Prepare url request from url
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        // request.timeoutInterval = 60
        let session = URLSession.shared
        // Build a data task with the request and get data, response and error
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            //If we get data properly and status code is 200
            if let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Data is \(data)")
                print("Response is \(httpResponse)")
                do {
                    let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                    // print(dict)
                    let feed = dict["feed"] as! [String: Any]
                    // print(feed)
                    let entryArr = feed["entry"] as! [Any]
                    print("Entries \(entryArr)")
                    
                    for (_, value) in entryArr.enumerated() {
                        // print(value)
                        let valueDict = value as! [String: Any]
                        let title = valueDict["title"] as! [String: Any]
                       // print(title)
                        let label = title["label"]
                        // print(label)
                        let titleStr: String! = label as! String!
                        self.arr.append(titleStr)
                    }
                    self.tblView.reloadData()
                    
                } catch {
                    print("Error with description \(error)")
                }
                self.tblView.reloadData()
            }
        }
        //Resume or start the task in background
        task.resume()
        
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
}
