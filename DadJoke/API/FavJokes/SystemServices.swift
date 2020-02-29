//
//  SystemServices.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 11.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import Foundation
import SwiftUI

struct SystemServices: ViewModifier {
    static var favFetcher = FavouritesFetcher()

    func body(content: Content) -> some View {
        content
            // services
            .environmentObject(Self.favFetcher)
    }
}
