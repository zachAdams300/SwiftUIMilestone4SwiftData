//
//  DetailView.swift
//  SwiftMIlestone4SwiftData
//
//  Created by Zachary Adams on 1/26/24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    enum Mode {
        case adding, editing
    }
    
    var photo: Photo
    var mode: Mode
    @State private var photoName = ""
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Image(uiImage: UIImage(data: photo.imageData) ?? UIImage())
                .resizable()
                .scaledToFit()
            
            TextField("Name", text: $photoName)
            
            Button("Save") {
                photo.name = photoName
                
                if mode == .adding {
                    modelContext.insert(photo)
                }
                dismiss()
            }
        }
        .onAppear() {
            photoName = photo.name
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Photo.self, configurations: config)
    
    return DetailView(photo: Photo(name: "Hi", imageData: UIImage(systemName: "photo.badge.plus")!.jpegData(compressionQuality: 1)!), mode: .adding)
        .modelContainer(container)
}
