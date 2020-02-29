//
//  Connectivity.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 11.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
