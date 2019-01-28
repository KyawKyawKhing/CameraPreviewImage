//
//  ViewController.swift
//  CameraPreviewImage
//
//  Created by AcePlus101 on 1/25/19.
//  Copyright © 2019 AcePlus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ivPreview: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickTakePhtoButton(_ sender: UIButton) {
        takePhoto(sender, imagePickerControllerDelegate: self)
    }
    @IBAction func onClickUploadPhotoButton(_ sender: Any) {
        uploadPhoto(uploadImage: ivPreview.image ?? UIImage(named: "user_preivew")!)
    }
    
    func takePhoto(_ sender: UIButton, imagePickerControllerDelegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera(imagePickerControllerDelegate: imagePickerControllerDelegate)
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary(imagePickerControllerDelegate: imagePickerControllerDelegate)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openCamera(imagePickerControllerDelegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = imagePickerControllerDelegate
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func openGallary(imagePickerControllerDelegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    {
        imagePicker.delegate = imagePickerControllerDelegate
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.modalPresentationStyle = .overFullScreen
        self.present(imagePicker, animated: true)
    }
    
    func uploadPhoto(uploadImage:UIImage) {
        if let imageData = uploadImage.pngData() {
            print("Uploaded \(imageData) into Server")
            //                http://phat-kyi.herokuapp.com/public/images/1542385638.png
            //                Alamofire.upload(multipartFormData: { (multipartFormData) in
            //                    multipartFormData.append(imageData, withName: "image",fileName: "\(Date().millisecondsSince1970).png", mimeType: "image/png")
            //
            //                }, to:"https://phat-kyi.herokuapp.com/public/api/uploadImage", method : .post) { (result) in
            //
            //                    switch result {
            //
            //                    case .success(let upload, _, _):
            //
            //                        upload.uploadProgress(closure: { (progress) in
            //                            print("Upload Progress: \(progress.fractionCompleted)")
            //                        })
            //
            //                        upload.responseJSON { response in
            //
            //                            let api = response.result.value
            //
            //                            if let result = api {
            //
            //                                let json = JSON(result)
            //
            //                                if json["code"].int ?? 0 == 200 {
            //
            //                                    self.ivProfile.sd_setImage(with: URL(string: json["data"].string!), placeholderImage: UIImage(named: "profile-placeholder"))
            //
            //                                    print(json["data"].string!)
            //
            //                                } else {
            //                                    print(json["code"])
            //                                }
            //
            //                            } else {
            //
            //                                print(api)
            //
            //                            }
            //
            //                        }
            //
            //                        break
            //
            //                    case .failure(let error):
            //                        print(error)
            //                        break
            //
            //                    }
            //
            //                }
            
        } else {
            
        }
    }

}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            self.ivPreview.image = pickedImage
        } else {
            print("image is null")
        }
        
    }
    
}
