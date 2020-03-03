//
//  EntryListTableViewController.swift
//  NotificationPatternsJournal
//
//  Created by Colby Harris on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

// Creating a notification key that we can call from anywhere, also known as a global property
let notificationKey = Notification.Name(rawValue: "didChangeHappiness")

class EntryListTableViewController: UITableViewController {
    
    var averageHappiness: Int = 0 {
        //Property Observer - Fires when the value did get set
        didSet {
            // Shouting out that we just updated our average happiness.
            NotificationCenter.default.post(name: notificationKey, object: self.averageHappiness)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryTableViewCell else {return UITableViewCell()}
        let entry = EntryController.entries[indexPath.row]
        cell.setEntry(entry: entry, averageHappiness: 0)
        
        // Telling our runner who it should give tasks to
        cell.delegate = self // self is our current table view controller
        // Configure the cell...

        return cell
    }
    
    func updateAverageHappiness() {
        var totalHappiness = 0
        for entry in EntryController.entries {
            if entry.isIncluded {
                totalHappiness += entry.happiness
            }
        }
        averageHappiness = totalHappiness / EntryController.entries.count
    }
}
// Creating our intern (This is the person who will do stuff)
extension EntryListTableViewController: EntryTableViewCellDelegate {
    // Creating the function(instruction set) that the intern will follow when the intern is told to do something
    func switchToggledOnCell(cell: EntryTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell), let entry = cell.entry else {return}
        EntryController.updateEntry(entry: entry)
        updateAverageHappiness()
        cell.updateUI(averageHappiness: averageHappiness)
        
    }
}
