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

