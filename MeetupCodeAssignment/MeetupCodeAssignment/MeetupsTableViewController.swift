//
//  LocalTechMeetupsTableViewController.swift
//  MeetupCodeAssignment
//
//  Created by Dare Ryan on 1/3/16.
//  Copyright © 2016 co.cordproject. All rights reserved.
//

import UIKit

class MeetupsTableViewController: UITableViewController, MeetupsDataSourceDelegate {
    
    let meetupsDataSource = MeetupsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        setupTableView()
    }
    
    func setupDataSource() {
        meetupsDataSource.delegate = self
        meetupsDataSource.reload()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(UINib(nibName: "MeetupTableViewCell", bundle: nil), forCellReuseIdentifier: MeetupTableViewCell.reuseIdentifier())
    }
    
    func meetupsDataSourceDidLoad(sender: MeetupsDataSource) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return meetupsDataSource.numberOfSectionsInTable()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meetupsDataSource.numberOfRowsInSection(section)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return meetupsDataSource.titleForSection(section) as String
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(MeetupTableViewCell.reuseIdentifier()) as! MeetupTableViewCell
        cell.configureWithMeetup(meetupsDataSource.meetupForIndexPath(indexPath))
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MeetupTableViewCell.cellHeight()
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
}
