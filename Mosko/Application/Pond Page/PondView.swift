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
    
    @State var historySelection:Int = 1
    @State var isEditSetting: Bool = false
    @State var selectedItem = ""

    func publishloop() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            mqttManager.publish(with: "Pond/" + String(Double.random(in: pondViewModel.underLimit..<pondViewModel.upperLimit))+"/"+["Idle","Heating","Cooling"].randomElement()!)
            publishloop()
        }
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(
                            mqttManager.currentAppState.appConnectionState.isConnected ? .green : .red
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
                    Image(systemName: (mqttManager.currentAppState.action == "Cooling" ? "snowflake" : mqttManager.currentAppState.action == "Heating" ? "flame" : "zzz"))
                        .foregroundColor(
                            mqttManager.currentAppState.action == "Cooling" ? .blue : mqttManager.currentAppState.action == "Heating" ? .red : .black
                        )
                    Text(mqttManager.currentAppState.action)
                }
                Spacer()
//                HStack{
                    Text((mqttManager.currentAppState.temperature.prefix(4)) + "ºC")
                    .font(.system(.title))
//                }
                HStack {
                    Spacer()
                    Text("H: 20º")
                    Spacer()
                    Text("L: 30º")
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
                        if historySelection == 1 {
                            HistoryChartView(entries: Temperature.dataEntriesForHour( temperature: mqttManager.currentAppState.historyTemperature))
                                .frame(height: 300)
                            Text(selectedItem)
                        } else if historySelection == 0 {
                            HistoryChartView(entries: Temperature.dataEntriesForHour( temperature: mqttManager.currentAppState.historyTemperature))
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
                mqttManager.initializeMQTT(username: UDHelper.sharedUD.getUsername(), password: UDHelper.sharedUD.getPassword())
                mqttManager.connect()
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
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
