//
//  UDHelper.swift
//  mosko
//
//  Created by Deven Nathanael on 11/12/21.
//

import Foundation
enum UDKey: String{
    case newUser
    
    case pondName
    case fishType
    
    case upperLimit
    case underLimit
    
    case autoCool
    case autoHeat
}

class UDHelper {
    // MARK: Singleton Class
    static let sharedUD = UDHelper()
    
    let defaults = UserDefaults.standard
    
    func setUD(value: Any, key: String) {
        defaults.setValue(value, forKey: key)
    }
    
    func isNewUser() -> Bool {
        defaults.bool(forKey: UDKey.newUser.rawValue)
    }
    
    func setNotNewUser() {
        setUD(value: false, key: UDKey.newUser.rawValue)
    }
    
    func setPondName(pondName: String) {
        setUD(value: pondName, key: UDKey.pondName.rawValue)
    }
    
    func getPondName() -> String {
        return defaults.string(forKey: UDKey.pondName.rawValue) ?? "My Pond"
    }
    
    func setFishType(fishType: String) {
        setUD(value: fishType, key: UDKey.fishType.rawValue)
    }
    
    func getFishType() -> String {
        return defaults.string(forKey: UDKey.fishType.rawValue) ?? "My Fish"
    }
    
    func setUpperLimit(upperLimit: Double) {
        setUD(value: upperLimit, key: UDKey.upperLimit.rawValue)
    }
    
    func getUpperLimit() -> Double {
        return defaults.double(forKey: UDKey.upperLimit.rawValue) == 0.0 ? 30 : defaults.double(forKey: UDKey.upperLimit.rawValue)
    }
    
    func setUnderLimit(underLimit: Double) {
        setUD(value: underLimit, key: UDKey.underLimit.rawValue)
    }
    
    func getUnderLimit() -> Double {
        return defaults.double(forKey: UDKey.underLimit.rawValue) == 0.0 ? 20 : defaults.double(forKey: UDKey.underLimit.rawValue)
    }
    
    func setAutoCool(autoCool: Bool) {
        setUD(value: autoCool, key: UDKey.autoCool.rawValue)
    }
    
    func getAutoCool() -> Bool {
        return defaults.bool(forKey: UDKey.autoCool.rawValue)
    }
    
    func setAutoHeat(autoHeat: Bool) {
        setUD(value: autoHeat, key: UDKey.autoHeat.rawValue)
    }
    
    func getAutoHeat() -> Bool {
        return defaults.bool(forKey: UDKey.autoHeat.rawValue)
    }
}
