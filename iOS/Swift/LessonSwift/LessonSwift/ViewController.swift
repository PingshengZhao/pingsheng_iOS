//
//  ViewController.swift
//  LessonSwift
//
//  Created by pingsheng on 16/4/12.
//  Copyright © 2016年 pingsheng.zhao. All rights reserved.
//

import UIKit
import Cartography
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var tableView: UITableView!
    var dataArray = ["练习Layout","暂无1","暂无2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "主页";
        tableView = UITableView.init(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView.init(frame: CGRectZero)
        view.addSubview(self.tableView)
       
        constrain(tableView) { tableView in
            tableView.edges == inset(tableView.superview!.edges, 0, 0, 0, 0)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellid = "cellid"
        var tableViewCell = tableView.dequeueReusableCellWithIdentifier(cellid)
        if (tableViewCell == nil) {
            tableViewCell = UITableViewCell.init(style: .Default, reuseIdentifier: cellid)
        }
        tableViewCell?.textLabel?.text = dataArray[indexPath.row]
        return tableViewCell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        navigationController?.pushViewController(ViewController(), animated: true)
    }
}

