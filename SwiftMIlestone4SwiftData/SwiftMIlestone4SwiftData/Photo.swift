//
//  Person.swift
//  SwiftMIlestone4SwiftData
//
//  Created by Zachary Adams on 1/26/24.
//

import Foundation
import SwiftData

@Model
class Photo {
    let id = UUID()
    
    var name: String
    @Attribute(.externalStorage) var imageData: Data
    
    init(name: String, imageData: Data) {
        self.name = name
        self.imageData = imageData
    }
}
