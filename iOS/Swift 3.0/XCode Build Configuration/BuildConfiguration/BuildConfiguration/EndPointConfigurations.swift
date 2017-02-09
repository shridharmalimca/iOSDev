//
//  EndPointConfigurations.swift
//  BuildConfiguration
//
//  Created by Shridhar Mali on 2/9/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import Foundation


public enum Enviornment: String {
    case Debug = "Debug"
    case AdHoc = "AdHoc"
    case Release = "Release"
    
    var serverBaseUrl : String {
        switch self {
        case .Debug : return "https://www.debugServer.com"
        case .AdHoc : return "https://www.adHocServer.com"
        case .Release: return "https://www.releaseServer.com"
            
        }
    }
}

public struct Configuration {
    static var enviornment : Enviornment {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "APP_ENVIORNMENT_CONFIGURATION") as? String {
            if let _ = configuration.range(of: "Debug") {
                return Enviornment.Debug
            }
            if let _ = configuration.range(of: "AdHoc") {
                return Enviornment.AdHoc
            }
            if let _ = configuration.range(of: "Release") {
                return Enviornment.Release
            }
            
            // Add more configurations here
            
        }
        // Default Debug will be return
        return Enviornment.Debug
    }
}
