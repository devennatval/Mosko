//
//  SettingsView.swift
//  mosko
//
//  Created by Deven Nathanael on 14/11/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var pondViewModel: PondViewModel
 
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Pond's Information")) {
                    SettingTextRowView(titleSetting: "Pond's Name", inputPlaceholder: "Your pond's name",inputText: $pondViewModel.pondName)
                    SettingTextRowView(titleSetting: "Fish Type", inputPlaceholder: "Your fish type", inputText: $pondViewModel.fishType)
                }
                
                Section(header: Text("Limit Notification")) {
                    HStack {
                        VStack {
                            HStack {
                                Text("Temperature")
                                Spacer()
                                Text("Min")
                                Text(String(format: "%.1f", pondViewModel.underLimit))
                                Spacer()
                                Text("Max")
                                Text(String(format: "%.1f", pondViewModel.upperLimit))
                            }
                            .padding(.vertical, 5)
                            HStack {
                                LimitSliderView(minValue: $pondViewModel.underLimit, maxValue: $pondViewModel.upperLimit, allowed: 20...35, step: 0.1)
                            }
                        }
                    }
                }
                
                Section(header: Text("Automation")) {
                    Toggle(isOn: $pondViewModel.autoCool) {
                        Text("Automatic Cooling")
                    }
                    Toggle(isOn: $pondViewModel.autoHeat) {
                        Text("Automatic Heating")
                    }
                }
            }
            
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    pondViewModel.refreshData()
                    dismiss.callAsFunction()
                }, label: {
                    Text("Cancel")
                })
                ,trailing: Button(action: {
                    pondViewModel.saveData()
                    dismiss.callAsFunction()
                }, label: {
                    Text("Apply")
                }))
        }
        .listStyle(.insetGrouped)
    }
}
