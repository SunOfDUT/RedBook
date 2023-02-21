//
//  ImagePicker.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/5.
//
import SwiftUI
struct Imagepicker : UIViewControllerRepresentable{
    @Binding var ispick : Bool
    @Binding var Imagedata : Data
    
    func makeCoordinator() -> Coordinator {
        return Imagepicker.Coordinator(parent1: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.isEditing = true
        picker.setEditing(true, animated: true)
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        var parent : Imagepicker
        
        init(parent1:Imagepicker) {
            self.parent = parent1
        }
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.ispick = false
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            let imagedata = image.jpegData(compressionQuality: 1)!
            parent.Imagedata = imagedata
            parent.ispick = false
        }
    }
}
