//
//  Configuration.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 26.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

class Configuration {
    
    static public let shared = Configuration()
    
    private init() {}
    
    private let apiKey: String = {
        return "5232a9bca11e25c0f8eb4313ff2644be"
    }()
    
    public let serverURL: String = {
        let url = "https://api.bincodes.com/cc/?format=json&api_key=\(Configuration.shared.apiKey)&cc=[CC]"
        return url
    }()
}
