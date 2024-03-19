//
// Created for Camera Photos SwiftData
// by  Stewart Lynch on 2024-03-18
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import SwiftUI
import SwiftData
import PhotosUI

struct UpdateEditFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State var vm: UpdateEditFormViewModel
    @State private var imagePicker = ImagePicker()
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $vm.name)
                VStack {
                    if vm.data != nil {
                        Button("Clear image") {
                            vm.clearImage()
                        }
                        .buttonStyle(.bordered)
                    }
                    HStack {
                        Button("Camera", systemImage: "camera") {
                            
                        }
                        PhotosPicker(selection: $imagePicker.imageSelection) {
                            Label("Photos", systemImage: "photo")
                        }
                    }
                    .foregroundStyle(.white)
                    .buttonStyle(.borderedProminent)
                    Image(uiImage: vm.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()
                }
            }
            .onAppear {
                imagePicker.setup(vm)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if vm.isUpDating {
                            if let sample = vm.sample {
                                if vm.image != Constants.placeholder {
                                    sample.data = vm.image.jpegData(compressionQuality: 0.8)
                                } else {
                                    sample.data = nil
                                }
                                sample.name = vm.name
                                dismiss()
                            }
                        } else {
                            let newSample = SampleModel(name: vm.name)
                            if vm.image != Constants.placeholder {
                                newSample.data = vm.image.jpegData(compressionQuality: 0.8)
                            } else {
                                newSample.data = nil
                            }
                            modelContext.insert(newSample)
                            dismiss()
                        }
                    } label: {
                        Text(vm.isUpDating ? "Update" : "Add")
                    }
                    .disabled(vm.isDisabled)
                }
            }
        }
    }
}

#Preview {
    UpdateEditFormView(vm: UpdateEditFormViewModel())
}
