//
//  ContentView.swift
//  SwiftMIlestone4SwiftData
//
//  Created by Zachary Adams on 1/26/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ContentView: View {
    @Query var photos: [Photo]
    @State private var selectedItem: PhotosPickerItem?
    @State private var photoToAdd: Photo?
    @State private var photoToEdit: Photo?
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            if photos.count < 1 {
                PhotosPicker(selection: $selectedItem) {
                    ContentUnavailableView("No people added", systemImage: "photo.badge.plus", description: Text("Tap to add"))
                }
                .onChange(of: selectedItem) { oldValue, newValue in
                    Task {
                        await getPhotoFromSelectedItem()
                    }
                }
            }else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20, content: {
                        ForEach(photos) { photo in
                            PhotoListView(photo: photo)
                                .onTapGesture {
                                    photoToEdit = photo
                                }
                        }
                    })
                }
                .padding(.horizontal)
                .navigationTitle("Photos List")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    PhotosPicker(selection: $selectedItem) {
                        Label("Add", systemImage: "plus")
                    }
                    .onChange(of: selectedItem) { oldValue, newValue in
                        Task {
                            await getPhotoFromSelectedItem()
                        }
                    }
                }
            }
        }
        .sheet(item: $photoToAdd) { photo in
            DetailView(photo: photo, mode: .adding)
        }
        .sheet(item: $photoToEdit) { photo in
            DetailView(photo: photo, mode: .editing)
        }
    }
    
    func getPhotoFromSelectedItem() async {
        do {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            selectedItem = nil
            photoToAdd = Photo(name: "", imageData: imageData)
        }catch {
            print("Oof")
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Photo.self, configurations: config)
    
    let photo = Photo(name: "Hi Test", imageData: UIImage(systemName: "photo.badge.plus")!.jpegData(compressionQuality: 1)!)
    
    container.mainContext.insert(photo)
    
    return ContentView()
        .modelContainer(container)
}
