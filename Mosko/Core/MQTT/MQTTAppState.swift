//
//  MQTTAppState.swift
//  Mosko2
//
//  Created by Deven Nathanael on 23/12/21.
//

import Combine
import Foundation

enum MQTTAppConnectionState {
    case connected
    case disconnected
    case connecting
    case connectedSubscribed
    case connectedUnSubscribed

    var description: String {
        switch self {
        case .connected:
            return "Connected"
        case .disconnected:
            return "Disconnected"
        case .connecting:
            return "Connecting"
        case .connectedSubscribed:
            return "Subscribed"
        case .connectedUnSubscribed:
            return "Connected Unsubscribed"
        }
    }
    var isConnected: Bool {
        switch self {
        case .connected, .connectedSubscribed, .connectedUnSubscribed:
            return true
        case .disconnected,.connecting:
            return false
        }
    }
    
    var isSubscribed: Bool {
        switch self {
        case .connectedSubscribed:
            return true
        case .disconnected,.connecting, .connected,.connectedUnSubscribed:
            return false
        }
    }
}

final class MQTTAppState: ObservableObject {
    @Published var appConnectionState: MQTTAppConnectionState = .disconnected
    @Published var historyTemperature: [Temperature] = [] {
        didSet {
            UDHelper.sharedUD.saveTemperatures(temperatures: historyTemperature)
        }
    }
    @Published var temperature: String = "--.-"
    @Published var minTemp: Double = 0.0
    @Published var maxTemp: Double = 0.0
    @Published var action: String = "Off"
    
    private var receivedMessages: [String] = []

    func setReceivedMessage(text: String) {
        receivedMessages = text.components(separatedBy: "/")
        
        if receivedMessages[0] == "Pond" {
            let date = Date()
            let calendar = Calendar.current
            
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            
            action = receivedMessages[2]
            temperature = receivedMessages[1]
            if !historyTemperature.contains(where: {$0.hour == hour && $0.minute == minute}) {
                historyTemperature.append(Temperature(date: date, hour: hour, minute: minute, temperature: Double(temperature) ?? 0.0))
            }
            else {
                historyTemperature.removeAll(where: {$0.hour == hour && $0.minute == minute})
                historyTemperature.append(Temperature(date: date, hour: hour, minute: minute, temperature: Double(temperature) ?? 0.0))
            }
            
            let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date()) ?? Date()
            var minuteTemperature = historyTemperature.filter{$0.date > hourAgo}
            minuteTemperature.sort(by: { $0.temperature < $1.temperature})
            minTemp = minuteTemperature.first?.temperature ?? 0.0
            maxTemp = minuteTemperature.last?.temperature ?? 0.0
            
            if NotificationManager.sharedNM.blastReady == true {
                if (Double(temperature) ?? 0.0) > UDHelper.sharedUD.getUpperLimit() {
                    NotificationManager.sharedNM.createLocalNotification(condition: "Upperlimit")
                } else if (Double(temperature) ?? 0.0) < UDHelper.sharedUD.getUnderLimit() {
                    NotificationManager.sharedNM.createLocalNotification(condition: "Underlimit")
                }
            }
            
        }
        
        
    }

    func clearData() {
        receivedMessages = []
        historyTemperature = []
    }

    func setAppConnectionState(state: MQTTAppConnectionState) {
        appConnectionState = state
    }
}
