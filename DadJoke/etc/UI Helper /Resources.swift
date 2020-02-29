//
//  Resources.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 07.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import Foundation
import SwiftUI

class Resources {

    static let shared = Resources()
    
    // MARK: - Properties
    private var colors: Gradient
    var gradient: RadialGradient
    
    // Initialization

    private init() {
        self.colors = Gradient(colors: [.red, .blue])
        self.gradient = RadialGradient(gradient: colors, center: .center, startRadius: 50, endRadius: 200)
    }

}
