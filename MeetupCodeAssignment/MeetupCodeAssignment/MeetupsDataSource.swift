//
//  MeetupsDataSource.swift
//  MeetupCodeAssignment
//
//  Created by Dare Ryan on 1/3/16.
//  Copyright © 2016 co.cordproject. All rights reserved.
//

import CoreLocation
import UIKit

protocol MeetupsDataSourceDelegate {
    func meetupsDataSourceDidLoad(sender: MeetupsDataSource)
}

class MeetupsDataSource: NSObject, UserLocationManagerDelegate {
    
    private var meetupDateDictionary = [NSString: Array<Meetup>]()
    private var orderedMeetupDateStrings = Array<NSString>()
    let eventDateDateFormatter = NSDateFormatter()
    let eventTimeDateFormatter = NSDateFormatter()
    var delegate: MeetupsDataSourceDelegate?
    let locationManager = UserLocationManager()
    
    // MARK: - Init
    
    override init() {
        super.init()
        setupLocationManager()
        setupDateFormatters()
    }
    
    // MARK: - Setup
    
    func setupLocationManager() {
        locationManager.delegate = self;
        
    }
    
    func setupDateFormatters() {
        eventDateDateFormatter.dateFormat = "EEEE, MMMM d"
        eventTimeDateFormatter.dateFormat = "h:mm a"
    }
    
    // MARK: - Factories
    
    func startDateDictionaryKeyFromDate(date: NSDate?) -> NSString {
        if date == nil {
            return ""
        }
        
        return eventDateDateFormatter.stringFromDate(date!)
    }
    
    func startTimeStringFromDate(date: NSDate?) -> NSString {
        if date == nil {
            return ""
        }
        
        return eventTimeDateFormatter.stringFromDate(date!)
    }
    
    // MARK: - Imperatives
    
    func reload() {
        self.meetupDateDictionary = [NSString: Array<Meetup>]()
        self.orderedMeetupDateStrings = Array<NSString>()
        locationManager.updateCurrentUserLocation()
    }
    
    func updateMeetups(location: CLLocation) {
        MeetupAPIClient.fetchTechMeetups(location.coordinate) { (response) -> Void in
            if response != nil {
                for responseObject in response! {
                    let meetup = Meetup(jsonResponseObject: responseObject as! NSDictionary)
                    meetup.setFormattedStartTimeString(self.startTimeStringFromDate(meetup.startDate) as String)
                    let startDate = self.startDateDictionaryKeyFromDate(meetup.startDate)
                    
                    if self.meetupDateDictionary[startDate] != nil {
                        self.meetupDateDictionary[startDate]!.append(meetup)
                    }else{
                        let meetupsOnDateArray = [meetup]
                        self.meetupDateDictionary[startDate] = meetupsOnDateArray
                        self.orderedMeetupDateStrings.append(startDate)
                    }
                }
                self.delegate?.meetupsDataSourceDidLoad(self)
            }
        }
    }

    
    // MARK: - Location Manager Delegate
    
    func locationManagerDidUpdateLocation(sender: UserLocationManager, location: CLLocation) {
        updateMeetups(location)
    }
    
    // MARK: - Accessors
    
    func numberOfRowsInSection(section: Int) -> Int {
        
        if let sectionKey = orderedMeetupDateStrings[section] as NSString!{
            let sectionCount = meetupDateDictionary[sectionKey]!.count
            return sectionCount
        }else{
            return 0
        }
    }
    
    func numberOfSectionsInTable () -> Int {
        return orderedMeetupDateStrings.count
    }
    
    func meetupForIndexPath(index: NSIndexPath) -> Meetup {
        let sectionKey = orderedMeetupDateStrings[index.section]
        let sectionArray = meetupDateDictionary[sectionKey]
        return sectionArray![index.row]
    }
    
    func titleForSection(section: Int) -> NSString {
        return orderedMeetupDateStrings[section]
    }
}
