//
//  ViewController.swift
//  PlistToTableView
//
//  Created by 김종현 on 2017. 10. 1..
//  Copyright © 2017년 김종현. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var contents = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // 데이터 로드
        let path = Bundle.main.path(forResource: "Address2", ofType: "plist")
        contents = NSArray(contentsOfFile: path!)!
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let myTitle = (contents[indexPath.row] as AnyObject).value(forKey: "title")
        let myAddress = (contents[indexPath.row] as AnyObject).value(forKey: "address")
        
        print(myAddress!)
        
        myCell.textLabel?.text = myTitle as? String
        myCell.detailTextLabel?.text = myAddress as? String
        
        return myCell
    }

}
