//
//  DialogImageSelector.swift
//  expense management
//
//  Created by Jonatas Alves santos on 23/06/22.
//

import UIKit

public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
}

open class DialogImagePicker: NSObject {
    
    private let imagePickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.imagePickerController = UIImagePickerController()
        super.init()

        self.presentationController = presentationController
        self.delegate = delegate
        
        self.imagePickerController.delegate = self
        self.imagePickerController.allowsEditing = true
        self.imagePickerController.mediaTypes = ["public.image"]
    }
    
    public func present() {
        
        let alertController = UIAlertController(title: "DIALOG_IMG_MSG_TITLE".localize(), message: "DIALOG_IMG_MSG_SUBTITLE".localize(), preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "DIALOG_IMG_OPTION_CAMERA".localize()) {
            alertController.addAction(action)
        }
       
        if let action = self.action(for: .photoLibrary, title: "DIALOG_IMG_OPTION_LIBRARY".localize()) {
            alertController.addAction(action)
        }
        
        if let action = self.action(for: .savedPhotosAlbum, title: "DIALOG_IMG_OPTION_ALBUM".localize()) {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "BTN_LABEL_CANCEL".localize(), style: .cancel, handler: nil))
        
        self.presentationController?.present(alertController, animated: true, completion: nil)
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.imagePickerController.sourceType = type
            self.presentationController?.present(self.imagePickerController, animated: true)
        }
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.delegate?.didSelect(image: image)
    }
}

extension DialogImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension DialogImagePicker: UINavigationControllerDelegate {
}


