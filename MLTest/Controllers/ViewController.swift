//
//  ViewController.swift
//  MLTest
//
//  Created by Alex Wulff on 6/6/17.
//  Copyright © 2017 Conifer Apps. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var photoViewer: PhotoViewer!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var camera: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var photos: [UIImage] = [UIImage]()
        
        photos.append(#imageLiteral(resourceName: "airport.jpg"))
        photos.append(#imageLiteral(resourceName: "forrest.JPG"))
        photos.append(#imageLiteral(resourceName: "desert.jpg"))
        photos.append(#imageLiteral(resourceName: "mountain-low-res.jpg"))
        photos.append(#imageLiteral(resourceName: "mountain.jpg"))
        photos.append(#imageLiteral(resourceName: "stairs-low-res.jpg"))
        photos.append(#imageLiteral(resourceName: "stairs.jpg"))
        photos.append(#imageLiteral(resourceName: "sun.jpg"))
        
        self.photoViewer.images = photos
        
        self.photoViewer.onSelection = self.onImageSelection(_:)
        
        onImageSelection(#imageLiteral(resourceName: "airport.jpg"))
    }
    
    @IBAction func cameraPressed(_ sender: Any) {
        let takePhotoAlertController = UIAlertController(title: "Photo", message: "How would you like to get the photo?", preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (theAction) in
            let pickerController = UIImagePickerController()
            
            pickerController.sourceType = UIImagePickerControllerSourceType.camera
            
            pickerController.delegate = self
            
            pickerController.allowsEditing = false
            
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let rollAction = UIAlertAction(title: "Photo Roll", style: UIAlertActionStyle.default) { (theAction) in
            
            let pickerController = UIImagePickerController()
            
            pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            pickerController.delegate = self
            
            pickerController.allowsEditing = false
            
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (theAction) in
            
            
            
        }
        
        takePhotoAlertController.popoverPresentationController?.barButtonItem = self.camera
        
        takePhotoAlertController.addAction(cameraAction)
        takePhotoAlertController.addAction(rollAction)
        takePhotoAlertController.addAction(cancelAction)
        
        self.present(takePhotoAlertController, animated: true, completion: nil)
    }
    
    
    
    func myResultsMethod(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Results Error")
        }
        
        var string = ""
        
        for classification in results {
            
            string += "Item: \(classification.identifier), Confidence: \(classification.confidence)\n\n"
        }
        
        self.textView.text = ""
        self.textView.text = string
    }
    
    
    func onImageSelection(_ image: UIImage) {
        
        self.imageView.image = image
        self.textView.scrollRangeToVisible(NSMakeRange(0, 0))
        
        guard let cg_image = image.cgImage else {
            fatalError("Couldn't get cgImage")
        }
        
        guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else {
            fatalError("Couldn't initialize Model")
        }
        
        let request = VNCoreMLRequest(model: model, completionHandler: myResultsMethod)
        
        let handler = VNImageRequestHandler(cgImage: cg_image, options: [:])
        
        guard (try? handler.perform([request])) != nil else {
            fatalError("Error on model")
        }
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        picker.dismiss(animated: true) {
            
            
        }
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        self.photoViewer.images.append(image)
        
        let indexPath = IndexPath(row: self.photoViewer.images.count - 1, section: 0)
        
        self.photoViewer.collection?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        self.onImageSelection(image)
        
    }
    
    
}

