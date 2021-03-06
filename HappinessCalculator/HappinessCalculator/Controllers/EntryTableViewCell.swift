//
//  EntryTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Colby Harris on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit
// Declaring a Protocol and allowing it to use class level objects
protocol  EntryTableViewCellDelegate: class {
    // Creating a job that the boss (tableViewCell), can tell our interen (TableViewController) to do.
    func switchToggledOnCell(cell: EntryTableViewCell)
}


class EntryTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    //MARK: - Properties
    var entry: Entry?
    
    // Creating our runner that will tell our intern to do something
    weak var delegate: EntryTableViewCellDelegate?  // setting entryTableViewController to delegate if it exists needs to be of type protocol
    
    //MARK: - Helper Functions
    func setEntry(entry: Entry, averageHappiness: Int){
        self.entry = entry
        updateUI(averageHappiness: averageHappiness)
        createObserver()
    }

    func updateUI(averageHappiness: Int){
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabledSwitch.isOn = entry.isIncluded
        higherOrLowerLabel.text = entry.happiness >= averageHappiness ? "Higher" : "Lower"
    }
    
    func createObserver() {
        // Creating our person who will listen for our notification, then call recalculateHappiness
        NotificationCenter.default.addObserver(self, selector: #selector(recalculatedHappiness), name: notificationKey, object: nil) //default is a singleton from the notificationcenter class
    }
    
    @objc func recalculatedHappiness(notification: NSNotification){
        guard let averageHappiness = notification.object as? Int else {return}
        updateUI(averageHappiness: averageHappiness)
    }
    
    
    @IBAction func toggledIsIncluded(_ sender: Any) {
        // Telling our runner to go tell our intern to do something
        delegate?.switchToggledOnCell(cell: self)
    }
    
}
