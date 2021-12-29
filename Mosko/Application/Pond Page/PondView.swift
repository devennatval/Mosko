//
//  PondView.swift
//  mosko
//
//  Created by Deven Nathanael on 14/11/21.
//

import SwiftUI

struct PondView: View {
    @StateObject var mqttManager = MQTTManager.shared()
    @ObservedObject var pondViewModel = PondViewModel()
    
    func publishloop() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            mqttManager.publish(with: String(Double.random(in: 25..<27)))
            publishloop()
        }
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(pondViewModel.pondName)
                    .font(.system(.title))
                HStack {
                    Image("fish")
                    Text(pondViewModel.fishType)
                }
                .font(.system(.title3))
                HStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(
                            mqttManager.currentAppState.appConnectionState.isConnected ? .green : .red
                        )
                    Text(mqttManager.currentAppState.appConnectionState.isConnected ? "Connected" : "Disconnected")
                }
                HStack{
                    Text((mqttManager.currentAppState.historyText.last?.prefix(4) ?? "--") + "ºC")
                    .font(.system(size: 48))
                }
                HStack {
                    Spacer()
                    Text("H: 20º")
                    Spacer()
                    Text("L: 30º")
                    Spacer()
                }
                
                .padding(.horizontal, 100)
                .padding(.vertical, 1)

                HStack {
                    VStack {
                        Text("History")
                        Picker("", selection: $pondViewModel.historySelection) {
                            Text("Hours").tag(0)
                            Text("Days").tag(1)
                        }
                        .pickerStyle(.segmented)
                        if pondViewModel.historySelection == 1 {
                            HistoryChartView(entries: Temperature.dataEntriesForDay(0, temperature: Temperature.temperatureHistory))
                        } else if pondViewModel.historySelection == 0 {
                            HistoryChartView(entries: Temperature.dataEntriesForDay(1, temperature: Temperature.temperatureHistory))
                        }
                    }
                    
                    .padding()
                    .background(
                        Color(.white))
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.25), radius: 10, x: 0, y: 0)
                }

                .padding()
            }
            .sheet(isPresented: $pondViewModel.isEditSetting) {
                SettingsView(pondViewModel: pondViewModel)
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    HStack {
                        WeatherView()
                    }
                , trailing: Button(action: {
                    pondViewModel.isEditSetting.toggle()
                }, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.black)
                }))
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                mqttManager.initializeMQTT(username: "samuelmaynard13@gmail.com", password: "moskouser")
                mqttManager.connect()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                mqttManager.subscribe(topic: "samuelmaynard13@gmail.com/Mosko")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                publishloop()
            }
        }
        .environmentObject(mqttManager)
    }
}

struct PondView_Previews: PreviewProvider {
    static var previews: some View {
        PondView()
    }
}
