//
//  PhotoListView.swift
//  SwiftMIlestone4SwiftData
//
//  Created by Zachary Adams on 1/26/24.
//

import SwiftUI
import SwiftData

struct PhotoListView: View {
    var photo: Photo
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: photo.imageData) ?? UIImage())
                .resizable()
                .frame(width: 150, height: 100)
            
            Text(photo.name)
                .padding(.bottom)
        }
        .clipShape(.rect(cornerRadius: 16))
        .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.black, lineWidth: 1)
            )
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Photo.self, configurations: config)
    
    return PhotoListView(photo: Photo(name: "Hi", imageData: UIImage(systemName: "photo.badge.plus")!.jpegData(compressionQuality: 1)!))
        .modelContainer(container)
}
