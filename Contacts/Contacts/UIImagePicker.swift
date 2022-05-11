//
//  ImagePicker.swift
//  Contacts
//
//  Created by David Evans on 2/5/2022.
//

import PhotosUI
import SwiftUI

struct UIImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    
    // note that this could be .camera to bring up the camera
    // see https://direct.appcoda.com/swiftui-camera-photo-library/
    var sourceType: UIImagePickerController.SourceType

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = sourceType
        
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // do nothing
    }
    
    
    func makeCoordinator() -> Coordinator {  // called by SwiftUI
        Coordinator(self)
    }
    
    // Putting the Coordinator
    // inside to keep it modular.  It does not have to be.
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: UIImagePicker
        
        init(_ parent: UIImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = image
            }
        }
        
    }

}
