//
//  UDHelper.swift
//  mosko
//
//  Created by Deven Nathanael on 11/12/21.
//

import Foundation
enum UDKey: String{
    case newUser
    case firstTimeSetting
    
    case username
    case password
    case topic
    
    case pondName
    case fishType
    
    case upperLimit
    case underLimit
    
    case autoCool
    case autoHeat
    
    case temperatures
}

class UDHelper {
    // MARK: Singleton Class
    static let sharedUD = UDHelper()
    
    let defaults = UserDefaults.standard
    
    func setUD(value: Any, key: String) {
        defaults.setValue(value, forKey: key)
    }
    
    func isNewUser() -> Bool {
        return !defaults.bool(forKey: UDKey.newUser.rawValue)
    }
    
    func setNewUser(new: Bool) {
        setUD(value: !new, key: UDKey.newUser.rawValue)
    }
    
    func isDoneSetting() -> Bool {
        return !defaults.bool(forKey: UDKey.firstTimeSetting.rawValue)
    }
    
    func setDoneSetting(done: Bool) {
        setUD(value: !done, key: UDKey.firstTimeSetting.rawValue)
    }
    
    
    func setUsername(username: String) {
        setUD(value: username, key: UDKey.username.rawValue)
    }
    
    func getUsername() -> String {
        return defaults.string(forKey: UDKey.username.rawValue) ?? ""
    }
    
    func setPassword(password: String) {
        setUD(value: password, key: UDKey.password.rawValue)
    }
    
    func getPassword() -> String {
        return defaults.string(forKey: UDKey.password.rawValue) ?? ""
    }
    
    func setTopic(topic: String) {
        setUD(value: topic, key: UDKey.topic.rawValue)
    }
    
    func getTopic() -> String {
        return defaults.string(forKey: UDKey.topic.rawValue) ?? ""
    }
    
    func setPondName(pondName: String) {
        setUD(value: pondName, key: UDKey.pondName.rawValue)
    }
    
    func getPondName() -> String {
        return defaults.string(forKey: UDKey.pondName.rawValue) ?? ""
    }
    
    func setFishType(fishType: String) {
        setUD(value: fishType, key: UDKey.fishType.rawValue)
    }
    
    func getFishType() -> String {
        return defaults.string(forKey: UDKey.fishType.rawValue) ?? ""
    }
    
    func setUpperLimit(upperLimit: Double) {
        setUD(value: upperLimit, key: UDKey.upperLimit.rawValue)
    }
    
    func getUpperLimit() -> Double {
        return defaults.double(forKey: UDKey.upperLimit.rawValue) == 0.0 ? 35 : defaults.double(forKey: UDKey.upperLimit.rawValue)
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
    
    func saveTemperatures(temperatures: [Temperature]) {
        if let encodedData = try? JSONEncoder().encode(temperatures) {
            setUD(value: encodedData, key: UDKey.temperatures.rawValue)
        }
    }
    
    func getTemperatures() -> [Temperature] {
        guard
            let data = defaults.data(forKey: UDKey.temperatures.rawValue),
            let savedTemperatures = try? JSONDecoder().decode([Temperature].self, from: data)
        else { return [] }
        
        return savedTemperatures
    }
}
