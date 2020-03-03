//
//  EntryTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Colby Harris on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

protocol  EntryTableViewCellDelegate: class {
    func switchToggledOnCell(cell: EntryTableViewCell)
}


class EntryTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    //MARK: - Properties
    var entry: Entry?
    weak var delegate: EntryTableViewCellDelegate?  // setting entryTableViewController to delegate if it exists needs to be of type protocol
    
    //MARK: - Helper Functions
    func setEntry(entry: Entry, averageHappiness: Int){
        self.entry = entry
        updateUI(averageHappiness: averageHappiness)
    }

    func updateUI(averageHappiness: Int){
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabledSwitch.isOn = entry.isIncluded
        
        // Update HigherOrLowerLabel after notifications
        
    }
    
    @IBAction func toggledIsIncluded(_ sender: Any) {
        delegate?.switchToggledOnCell(cell: self)
    }
    
}
