//
//  PondView.swift
//  mosko
//
//  Created by Deven Nathanael on 14/11/21.
//

import SwiftUI

struct PondView: View {
    @ObservedObject var pondViewModel = PondViewModel()
    
    @State var historySelection:Int = 1
    @State var isEditSetting: Bool = false
    @State var selectedItem = " "

    // MARK: Generate Dummy Data
    func publishloop() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            pondViewModel.mqttManager.publish(with: "Pond/" + String(Double.random(in: 30..<31))+"/"+["Idle","Heating","Cooling"].randomElement()!)
            publishloop()
        }
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(
                            pondViewModel.mqttManager.currentAppState.appConnectionState.isConnected ? .green : .red
                        )
                    Text(pondViewModel.pondName)
                        .font(.system(.title2))
                }
                HStack {
                    Image("fish")
                    Text(pondViewModel.fishType)
                }
                .font(.system(.title3))
                HStack {
                    Image(systemName: (pondViewModel.mqttManager.currentAppState.action == "Cooling" ? "snowflake" : pondViewModel.mqttManager.currentAppState.action == "Heating" ? "flame" : "zzz"))
                        .foregroundColor(
                            pondViewModel.mqttManager.currentAppState.action == "Cooling" ? .blue : pondViewModel.mqttManager.currentAppState.action == "Heating" ? .red : .black
                        )
                    Text(pondViewModel.mqttManager.currentAppState.action)
                }
                Spacer()
//                HStack{
                Text((pondViewModel.mqttManager.currentAppState.temperature.prefix(4)) + "ºC")
                    .font(.system(.title))
//                }
                HStack {
                    Spacer()
                    Text("H: \(String(format: "%.1f", pondViewModel.mqttManager.currentAppState.maxTemp))")
                    Spacer()
                    Text("L: \(String(format: "%.1f", pondViewModel.mqttManager.currentAppState.minTemp))")
                    Spacer()
                }
                .padding(.horizontal, 100)
                .padding(.vertical, 0)

                HStack {
                    VStack {
                        Text("History")
                        Picker("", selection: $historySelection) {
                            Text("Hours").tag(0)
                            Text("Days").tag(1)
                        }
                        .pickerStyle(.segmented)
                        Text(selectedItem)
                        if historySelection == 1 {
                            HistoryChartView(entries: Temperature.dataEntriesForHour( temperature: pondViewModel.mqttManager.currentAppState.historyTemperature), selectedItem: $selectedItem)
                                .frame(height: 300)
                        } else if historySelection == 0 {
                            HistoryChartView(entries: Temperature.dataEntriesForDay( temperature: pondViewModel.mqttManager.currentAppState.historyTemperature), selectedItem: $selectedItem)
                                .frame(height: 300)
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
            .sheet(isPresented: $isEditSetting) {
                SettingsView(pondViewModel: pondViewModel)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    HStack {
                        WeatherView()
                    }
                , trailing:
                    Button(action: {
                        isEditSetting.toggle()
                    }, label: {
                        Image(systemName: "gear")
                            .foregroundColor(.black)
                    })
                )
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                pondViewModel.mqttManager.initializeMQTT(username: UDHelper.sharedUD.getUsername(), password: UDHelper.sharedUD.getPassword())
                pondViewModel.mqttManager.connect()
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+10) {
                if pondViewModel.mqttManager.currentAppState.action == "Off" {
                    NotificationManager.sharedNM.createLocalNotification(condition: "Offline")
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                publishloop()
            }
        }
        .environmentObject(pondViewModel.mqttManager)
    }
}

struct PondView_Previews: PreviewProvider {
    static var previews: some View {
        PondView()
    }
}
