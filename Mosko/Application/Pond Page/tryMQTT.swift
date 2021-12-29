//
//  tryMQTT.swift
//  Mosko
//
//  Created by Deven Nathanael on 27/12/21.
//

import SwiftUI

struct tryMQTT: View {
    @StateObject var mqttManager = MQTTManager.shared()
    
    func publishloop() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            mqttManager.publish(with: String(Double.random(in: 25..<27)))
            publishloop()
        }
        
    }
    
    var body: some View {
        VStack {
            Text(String(mqttManager.currentAppState.appConnectionState.description))
            Text(mqttManager.currentAppState.historyText.last ?? "")
            
            Spacer()
            Button(action: {
                mqttManager.initializeMQTT(username: "samuelmaynard13@gmail.com", password: "moskouser")
                mqttManager.connect()
            }, label: {
                Text("Init and Connect MQTT")
            })
            
            
            Button(action: {
                mqttManager.currentAppState.appConnectionState.isSubscribed ?  mqttManager.unSubscribe(topic: "samuelmaynard13@gmail.com/Mosko") : mqttManager.subscribe(topic: "samuelmaynard13@gmail.com/Mosko")
            }, label: {
                Text("SUBS")
            })
            
            Button(action: {
                publishloop()
            }, label: {
                Text("Try Publish")
            })
        }
        .environmentObject(mqttManager)

    }

}

struct tryMQTT_Previews: PreviewProvider {
    static var previews: some View {
        tryMQTT()
    }
}
