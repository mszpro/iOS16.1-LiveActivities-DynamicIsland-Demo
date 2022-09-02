//
//  TripAppAttributes.swift
//  LiveActivitiesTestiOS
//
//  Created by Sora on 2022/09/02.
//

import Foundation
import ActivityKit

struct TripAppAttributes: ActivityAttributes {
    
    enum TripStatus: String {
        case predeparture
        case inflight
        case landed
    }

    public struct ContentState: Codable, Hashable {
        var tripStatus: String
        var userStopPlanetName: String
        var userCabinNumber: String
        var arrivalTime: Date
    }
    
    var shipNumber: String
    var departureTime: Date
    
}
