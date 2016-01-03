//
//  MeetupTableViewCell.swift
//  MeetupCodeAssignment
//
//  Created by Dare Ryan on 1/3/16.
//  Copyright © 2016 co.cordproject. All rights reserved.
//

import UIKit

class MeetupTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventAttendeesLabel: UILabel!
    
    // MARK: - Setup
    
    func configureWithMeetup(meetup: Meetup) {
        
        if meetup.startTime != nil {
            timeLabel.text = meetup.startTime
        }else{
            timeLabel.text = ""
        }
        
        if meetup.groupName != nil{
            groupNameLabel.text = meetup.groupName
        }else{
            groupNameLabel.text = ""
        }
        
        if meetup.eventName != nil {
            eventNameLabel.text = meetup.eventName
        }else{
            eventNameLabel.text = ""
        }
        
        if meetup.attendees != nil && meetup.rsvpCount != nil {
            eventAttendeesLabel.text = "\(meetup.rsvpCount!) \(meetup.attendees!) going"
        }else{
            eventAttendeesLabel.text = ""
        }
    }
    
    // MARK: - Accessors
    
    class func cellHeight() -> CGFloat {
        return 110
    }
    
    class func reuseIdentifier() -> String {
        return "MeetupTableViewCell_reuseIdentifier"
    }
    
    // MARK: - Imperatives
    
    override func setSelected(selected: Bool, animated: Bool) {
        //Leaving this method with an empty implementation will prevent highlighting
    }
    
}

