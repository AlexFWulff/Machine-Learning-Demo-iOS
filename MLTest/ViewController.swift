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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else {
            fatalError("Couldn't initialize Model")
            
        }
        
        let request = VNCoreMLRequest(model: model, completionHandler: myResultsMethod)
        let handler = VNImageRequestHandler(url: Bundle.main.url(forResource: "airport", withExtension: "jpg")!)
        
        guard (try? handler.perform([request])) != nil else {
            fatalError("Error on model")
        }
    }
    
    func myResultsMethod(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Results Error")
        }
        
        for classification in results {
            print(classification.identifier, classification.confidence)
        }
        
    }
}

