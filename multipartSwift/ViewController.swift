//
//  ViewController.swift
//  multipartSwift
//
//  Created by Pawan Yadav on 17/07/18.
//  Copyright © 2018 invetech. All rights reserved.
//

import UIKit
import MobileCoreServices
import ImageIO



class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{

    @IBOutlet weak var pictureView: UIImageView!
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }

    
    @IBAction func btnClicked()
    {
        
      
        

        let imagePickerController = UIImagePickerController()

        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image", "public.movie"]

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else
            {
                self.showAlert(withTitle: "Missing camera", andMessage: "You can't take photo, there is no camera.")
            }
        }))


        actionSheet.addAction(UIAlertAction(title: "Choose From Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))


        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if pictureView.image != nil
        {
            actionSheet.addAction(UIAlertAction(title: "Remove Photo", style: .destructive, handler: {(_ action: UIAlertAction) -> Void in
                self.pictureView.image = nil
            }))
        }
        present(actionSheet, animated: true, completion: nil)
        
        
    }
    
 
    
    
    func showAlert(withTitle title: String, andMessage message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: {() -> Void in
            alert.view.tintColor = UIColor.green
        })
    }
}



extension ViewController
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        print(info)
        let mediaType = info["UIImagePickerControllerMediaType"] as! String
        switch mediaType
        {
        case "public.movie":
            print("Movie selected!")
            // TODO: Load video
            picker.dismiss(animated: true, completion: nil)
            break
        case "public.image":
            print("Image selected!")
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.pictureView.image = image
            picker.dismiss(animated: true, completion: nil)
            break
        default:
            picker.dismiss(animated: true, completion: nil)
            return
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        
        picker.dismiss(animated: true, completion: nil)
    }
}


//func MultiPartImage()
//{
//
//
//    if imageIsNullOrNot(imageName: imageUpload) == true
//    {
//      //  MBHUD.showHud(messgae: "Please wait..." , controller : self)
//
//        var someDict =  [String: String]()
//
//
//
//        someDict["access_key"] =  (UserDefaults .standard .value(forKey: "access_key") as! String)
//        someDict["staff_id"] = (UserDefaults .standard .value(forKey: "staff_Id") as! String)
//        someDict["lat"] = self.lat
//        someDict["lng"] = self.long
//        someDict["ip_add"] = getIpAdressViewController.getWiFiAddress()
//
//
//
//        //MARK:- Image convert In Data.
//        let dataImage = UIImageJPEGRepresentation(imagePicker, 0.6)!
//
//
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//
//
//            let jsonData = try? JSONSerialization.data(withJSONObject: someDict, options: [])
//            let jsonString = String(data: jsonData!, encoding: .utf8)
//
//
//            multipartFormData.append((jsonString?.data(using: .utf8)!)!, withName: "data")
//
//
//            //adding pic ---
//            multipartFormData.append(dataImage, withName: "file", fileName:"image" + ".jpg", mimeType: "image/png")
//
//
//
//        }, usingThreshold: UInt64.init(), to: "URL", method: .post, headers: nil)
//        {
//            (result) in
//
//            switch result
//            {
//
//            case .success(let upload, _, _):
//
//                upload.responseJSON
//                    {
//                        response in
//                        MBHUD .hideHud(message: "Image uploaded successfully!")
//
//                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FilterKey"), object: nil)
//                        self.navigationController!.popViewController(animated: true)
//                }
//            case .failure(let error):
//                print("Error in upload: \(error.localizedDescription)")
//                print(error)
//
//
//            }
//
//        }
//
//
//    }
//    else
//    {
//        alertViewCall.showMessage(title: "", msg: "Please Select Image", on: self)
//    }
//}
