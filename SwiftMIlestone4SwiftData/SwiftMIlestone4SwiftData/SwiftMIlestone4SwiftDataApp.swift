//
//  SwiftMIlestone4SwiftDataApp.swift
//  SwiftMIlestone4SwiftData
//
//  Created by Zachary Adams on 1/26/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftMIlestone4SwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Photo.self)
    }
}
