//
//  ViewController.swift
//  facedetect
//
//  Created by Prajjwal Gupta on 17/01/23.
//

import UIKit
import Vision

class ViewController: UIViewController {
    
    
    
    @IBOutlet var faceNotDetected: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named: "sample1") else
        { return }
        
  
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let scaleHeight = view.frame.width / image.size.width * image.size.height
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaleHeight)
        imageView.backgroundColor = .blue
        
        view.addSubview(imageView)
        
        let request = VNDetectFaceRectanglesRequest { (req,
                                                       err) in
            if let err = err {
                print("Feiled to detect faces:", err)
                return
            }
            // FOR PRINT VNDetectFaceRectanglesRequest
//            width must be aligned to 64-byte.
//            <VNDetectFaceRectanglesRequest: 0x2803be060>
//            VNDetectFaceRectanglesRequestRevision3 ROI=[0, 0, 1, 1]
       
            //  Code:   print(req)
            

//FOR Printing FACE OBSERVATION
            
//            <VNFaceObservation: 0x102bf12f0>
             req.results?.forEach({ (res) in
                
                guard let faceObservation = res as? VNFaceObservation else { return }
                 
                 
                 let x = self.view.frame.width * faceObservation.boundingBox.origin.x
                 let height = scaleHeight * faceObservation.boundingBox.height
                 let y = scaleHeight * (1 - faceObservation.boundingBox.origin.y) - height
                 let width = self.view.frame.width * faceObservation.boundingBox.width
                 
                 let redView = UIView()
                 redView.backgroundColor = .cyan
                 redView.alpha = 0.3
                 redView.frame = CGRect(x: x, y: y, width: width, height: height)
                 self.view.addSubview(redView)
                 
                 
                print(faceObservation.boundingBox)
                 
            })
         }
        guard let cgImage = image.cgImage else { return }
        
       let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([request])
        
        } catch let reqErr {
            print("Failed to perform request:", reqErr)
        }
            
     }
}

