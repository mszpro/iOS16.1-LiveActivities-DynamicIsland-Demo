//
//  ContentView.swift
//  LiveActivitiesTestiOS
//
//  Created by Sora on 2022/09/02.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    
    @State private var isActivityEnabled: Bool = true
    @State private var currentActivity: Activity<TripAppAttributes>?
    
    var body: some View {
        
        Form {
            
            Section("Status") {
                Button("Check permission") {
                    let isEnabled = ActivityAuthorizationInfo().areActivitiesEnabled
                    self.isActivityEnabled = isEnabled
                }
                Label(isActivityEnabled ? "Activity enabled" : "Activity not enabled",
                      systemImage: isActivityEnabled ? "checkmark.circle.fill" : "xmark.circle.fill")
            }
            
            Button("Create live activity") {
                let attributes = TripAppAttributes(shipNumber: "Space Warp 2",
                                                   departureTime: Calendar.current.date(byAdding: .minute, value: -2,
                                                                                        to: Date()) ?? Date())
                let contentState = TripAppAttributes.ContentState(tripStatus: TripAppAttributes.TripStatus.inflight.rawValue,
                                                                  userStopPlanetName: "M51 galaxy",
                                                                  userCabinNumber: "A12",
                                                                  arrivalTime: Calendar.current.date(byAdding: .minute, value: 8, to: Date()) ?? Date())
                do {
                    self.currentActivity = try Activity<TripAppAttributes>.request(
                        attributes: attributes,
                        contentState: contentState,
                        pushType: nil)
                } catch (let error) {
                    print(error.localizedDescription)
                }
            }
            
            Button("Get on-going activity") {
                let activities = Activity<TripAppAttributes>.activities
                self.currentActivity = activities.first
            }
            
            Button("Trip arrival time +10 minutes") {
                Task {
                    guard let currentActivity else { return }
                    let updatedState = TripAppAttributes.ContentState(tripStatus: TripAppAttributes.TripStatus.inflight.rawValue,
                                                                      userStopPlanetName: "M51 galaxy",
                                                                      userCabinNumber: "A12",
                                                                      arrivalTime: Calendar.current.date(byAdding: .minute, value: 10, to: currentActivity.contentState.arrivalTime) ?? Date())
                    await currentActivity.update(using: updatedState)
                }
            }
            
            Button("End activity") {
                Task {
                    guard let currentActivity else { return }
                    let updatedState = TripAppAttributes.ContentState(tripStatus: TripAppAttributes.TripStatus.landed.rawValue,
                                                                      userStopPlanetName: "M51 galaxy",
                                                                      userCabinNumber: "A12",
                                                                      arrivalTime: currentActivity.contentState.arrivalTime)
                    await currentActivity.end(using: updatedState, dismissalPolicy: .default)
                }
            }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
