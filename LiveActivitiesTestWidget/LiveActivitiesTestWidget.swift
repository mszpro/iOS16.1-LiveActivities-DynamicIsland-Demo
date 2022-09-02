//
//  LiveActivitiesTestWidget.swift
//  LiveActivitiesTestWidget
//
//  Created by Sora on 2022/09/02.
//

import WidgetKit
import SwiftUI
import Intents
import ActivityKit

struct LiveActivitiesTestWidgetEntryView : View {
    @State var attribute: TripAppAttributes
    @State var state: TripAppAttributes.ContentState

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Label("Ship number", systemImage: "moon.stars")
                Spacer()
                Text(attribute.shipNumber)
            }
            HStack {
                Label("Your stop", systemImage: "lanyardcard")
                Spacer()
                Text(state.userStopPlanetName)
            }
            switch TripAppAttributes.TripStatus(rawValue: state.tripStatus) {
            case .predeparture:
                HStack {
                    Label("Your cabin", systemImage: "person.fill")
                    Spacer()
                    Text(state.userCabinNumber)
                        .font(.title3.bold())
                }
            case .inflight:
                Label("Time to destination", systemImage: "clock")
                Text(state.arrivalTime, style: .timer)
                    .font(.largeTitle)
            case .landed:
                Label("Landed", systemImage: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title3)
                Text("Thanks for traveling with us!")
                    .font(.headline)
            default:
                Text("Unknown trip status")
            }
            
        }
        .padding()
    }
}

@main
struct LiveActivitiesTestWidget: Widget {
    let kind: String = "LiveActivitiesTestWidget"

    var body: some WidgetConfiguration {
        ActivityConfiguration(attributesType: TripAppAttributes.self) { context in
            LiveActivitiesTestWidgetEntryView(attribute: context.attributes,
                                              state: context.state)
        }
    }
}
