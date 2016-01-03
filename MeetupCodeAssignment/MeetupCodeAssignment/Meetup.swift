//
//  Meetup.swift
//  MeetupCodeAssignment
//
//  Created by Dare Ryan on 1/3/16.
//  Copyright © 2016 co.cordproject. All rights reserved.
//

import UIKit

class Meetup: NSObject {
    
    private(set) var eventName: String?
    private(set) var groupName: String?
    private(set) var attendees: String?
    private(set) var rsvpCount: Int?
    private(set) var distance: Double?
    private(set) var eventURL: NSURL?
    private(set) var startDate: NSDate?
    private(set) var startTime: String?
    
    init(jsonResponseObject: NSDictionary) {
        eventName = jsonResponseObject["name"] as? String
        groupName = jsonResponseObject["group"]?["name"] as? String
        attendees = jsonResponseObject["group"]?["who"] as? String
        rsvpCount = jsonResponseObject["yes_rsvp_count"] as? Int
        distance = jsonResponseObject["distance"] as? Double
        //Prevent providing nil URLString parameter when initializing NSURL
        if let URLString = jsonResponseObject["event_url"] as? String {
            eventURL = NSURL(string: URLString)
        }
        //Prevent calling timeIntervalSince1970 with nil, 0, or negative Double parameter
        let UTCTimeInterval = jsonResponseObject["time"] as? Double
        if UTCTimeInterval != nil && UTCTimeInterval > 0 {
            let offSetTime = (UTCTimeInterval!/1000)
            startDate = NSDate(timeIntervalSince1970: offSetTime)
        }
    }
    
    
    func setFormattedStartTimeString(start: String) {
        startTime = start
    }
}

