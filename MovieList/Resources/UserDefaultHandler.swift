//
//  UserDefaultHandler.swift
//  MovieList
//
//  Created by Azad on 5/6/21.
//

import Foundation


class UserDefaultsHandler{
    
    enum KEY: String {
        case imageBaseUrl = "ImageBaseUrl"
    }
    
    static func save<T: Codable>(key : KEY, value : T){
        //print("Codable Executed")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key.rawValue)
        }
    }
    
    static func loadCodable<T: Codable>(key : KEY, value : T.Type) -> T?{
        let defaults = UserDefaults.standard
        if let savedPerson = defaults.object(forKey: key.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let loaded = try? decoder.decode(T.self, from: savedPerson) {
                return loaded
            }
        }
        return nil
    }
    
    static func remove(key:KEY){
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func removeAll(){
        if let bundleID = Bundle.main.bundleIdentifier {
            print("All userdefault data has been removed")
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        } else {
            print("Could not find bundle identifier while removing user default")
        }
    }
    
    
}

