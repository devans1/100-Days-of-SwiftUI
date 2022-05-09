//
//  ImagePicker.swift
//  Contacts
//
//  Created by David Evans on 2/5/2022.
//

import PhotosUI
import SwiftUI

struct ImagePickerUI: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    // put it inside to keep it modular
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePickerUI
        
        init(_ parent: ImagePickerUI) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // dismiss the sheet using the passed ViewController
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
                
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator   // use this coordinator for the PHPicker - report it to our Coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // do nothing
    }
    
    
    func makeCoordinator() -> Coordinator {  // called by SwiftUI
        Coordinator(self)
    }
    
}
