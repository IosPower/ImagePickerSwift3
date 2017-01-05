//
//  ViewController.swift
//  ImagePicker

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIGestureRecognizerDelegate{

    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var uploadPhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgview.tag = 1
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)))
        tap.numberOfTapsRequired = 1
        tap.delegate = self
        imgview.isUserInteractionEnabled = true
        imgview.addGestureRecognizer(tap)
    }
    
    func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        let imagview = sender?.view
        print(imagview?.tag ?? "")
        if imgview.image != nil {
            openImageFromImageview(image: imgview.image!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Button Actions
    @IBAction func uploadPhoto(_ sender: Any) {
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Select Photo", message: "", preferredStyle: .actionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Photo", style: .default)
        { action -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = false
                imagePicker.showsCameraControls = true
                imagePicker.mediaTypes = [kUTTypeImage as String]
                self.present(imagePicker, animated: true, completion: nil)
            }
            
        }
        actionSheetController.addAction(takePictureAction)
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose Photo", style: .default)
        { action -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                imagePicker.allowsEditing = true
                imagePicker.mediaTypes = [kUTTypeImage as String]
                self.present(imagePicker, animated: true, completion: nil)
            }
        }

        actionSheetController.addAction(choosePictureAction)
        
        //We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func btnShow(_ sender: Any) {
        openImage(imgURL: URL(string:"http://www.tech-myanmar.com/wp-content/uploads/2015/04/apple-logo.png")!)
    }

    //MARK: - ImagePicker Delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("didFinishPickingMediaWithInfo")
       let imageProfile = (info[UIImagePickerControllerOriginalImage] as! UIImage)
      dismiss(animated: true) { 
        self.imgview.image = imageProfile
        }
    }
    
    func openImageFromImageview(image: UIImage) {
        let xibView = Bundle.main.loadNibNamed("ViewForImageZoom", owner: self, options: nil)?[0] as! ViewForImageZoom
        xibView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        let win:UIWindow = UIApplication.shared.delegate!.window!!
        xibView.image = image
        win.addSubview(xibView)
        xibView.setupViewForTapOpenImage()
    }
    
    func openImage(imgURL: URL) {
        let xibView = Bundle.main.loadNibNamed("ViewForImageZoom", owner: self, options: nil)?[0] as! ViewForImageZoom
        xibView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        xibView.imageURL = imgURL
        let win:UIWindow = UIApplication.shared.delegate!.window!!
        win.addSubview(xibView)
        xibView.setupViewForPinch()
    }
}

