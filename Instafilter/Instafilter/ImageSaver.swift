//
//  ImageSaver.swift
//  Instafilter
//
//  Created by David Evans on 2/5/2022.
//

import UIKit

class ImageSaver: NSObject {
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
    
}
