//
//  PondViewModel.swift
//  mosko
//
//  Created by Deven Nathanael on 07/12/21.
//

import Foundation
import SwiftUI

class PondViewModel: ObservableObject {
    @Published var pondName: String
    @Published var fishType: String
    
    @Published var upperLimit: Double
    @Published var underLimit: Double
    
    @Published var autoCool: Bool
    @Published var autoHeat: Bool

    init() {
        pondName = UDHelper.sharedUD.getPondName()
        fishType = UDHelper.sharedUD.getFishType()
        
        upperLimit = UDHelper.sharedUD.getUpperLimit()
        underLimit = UDHelper.sharedUD.getUnderLimit()
        
        autoCool = UDHelper.sharedUD.getAutoCool()
        autoHeat = UDHelper.sharedUD.getAutoHeat()
    }
    
    func refreshData() {
        pondName = UDHelper.sharedUD.getPondName()
        fishType = UDHelper.sharedUD.getFishType()
        
        upperLimit = UDHelper.sharedUD.getUpperLimit()
        underLimit = UDHelper.sharedUD.getUnderLimit()
        
        autoCool = UDHelper.sharedUD.getAutoCool()
        autoHeat = UDHelper.sharedUD.getAutoHeat()
        print("Refresh Data!")
    }
    
    func saveData() {
        UDHelper.sharedUD.setPondName(pondName: pondName)
        UDHelper.sharedUD.setFishType(fishType: fishType)
        UDHelper.sharedUD.setUpperLimit(upperLimit: upperLimit)
        UDHelper.sharedUD.setUnderLimit(underLimit: underLimit)
        UDHelper.sharedUD.setAutoCool(autoCool: autoCool)
        UDHelper.sharedUD.setAutoHeat(autoHeat: autoHeat)
        print("Save Data!")
    }
}
