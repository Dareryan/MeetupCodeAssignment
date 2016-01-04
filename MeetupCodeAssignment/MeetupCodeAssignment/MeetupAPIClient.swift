//
//  MeetupAPIClient.swift
//  MeetupCodeAssignment
//
//  Created by Dare Ryan on 1/3/16.
//  Copyright © 2016 co.cordproject. All rights reserved.
//
import CoreLocation
import UIKit

struct MeetupAPIClientConstants {
    //Warning: set API Key here
    static let MeetupApiClient_apiKey = ""
}

class MeetupAPIClient: NSObject {
    
    class func fetchTechMeetups(coordinates: CLLocationCoordinate2D, completion: (NSArray?) -> Void) {
        let urlComponents = NSURLComponents(string: "https://api.meetup.com/2/open_events")
        urlComponents!.queryItems = [
            NSURLQueryItem(name: "key", value: MeetupAPIClientConstants.MeetupApiClient_apiKey),
            NSURLQueryItem(name: "sign", value: "true"),
            NSURLQueryItem(name: "lat", value: "\(coordinates.latitude)"),
            NSURLQueryItem(name: "lon", value: "\(coordinates.longitude)"),
            NSURLQueryItem(name: "radius", value: "smart"),
            NSURLQueryItem(name: "format", value: "json"),
            NSURLQueryItem(name: "category", value: "34"),
            NSURLQueryItem(name: "limited_events", value: "true")
        ]
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: urlComponents!.URL!)
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request) {(let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error getting meetups: \(error)")
                completion(nil)
                return
            }
            
            do{
                let responseDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:.MutableContainers)
                let responseArray = responseDictionary["results"] as? NSArray
                completion(responseArray)
            }catch let serializationError as NSError {
                print("error serializing JSON: \(serializationError)")
                completion(nil)
            }
        }
        task.resume()
    }
}
