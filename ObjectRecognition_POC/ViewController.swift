//
//  ViewController.swift
//  BaseCode
//
//  Created by orange on 11/04/24.
//

import UIKit
import CoreML
import Vision
import NaturalLanguage

class ViewController: UIViewController {

    @IBOutlet weak var objectImageView: UIImageView!
    @IBOutlet weak var objectNameLbl: UILabel!
    
    @IBOutlet weak var btnSelectObject: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupImagePicker()
    }

    func setupImagePicker() {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .photoLibrary
        
    }

    @IBAction func btnSelectObjectAction(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imagePicker.dismiss(animated: true, completion: nil)
        guard let imageData = info[.originalImage] as? UIImage else { return }
        
        self.objectImageView.image = imageData
        
        // Convert the image for CIImage
        if let ciImage = CIImage(image: imageData) {
            self.processImage(ciImage: ciImage)
        }else {
            print("CIImage convert error")
        }
        
    }
    
    // Process Image output
    func processImage(ciImage: CIImage){
        do{
            let model = try VNCoreMLModel(for: MobileNetV2().model)
            
            let request = VNCoreMLRequest(model: model) { (request, error) in
                self.processClassifications(for: request, error: error)
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                let handler = VNImageRequestHandler(ciImage: ciImage, orientation: .up)
                do {
                    try handler.perform([request])
                } catch {
                    print("Failed to perform classification.\n\(error.localizedDescription)")
                }
            }
            
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                print("Unable to classify image.\n\(error!.localizedDescription)")
                return
            }
            
            let classifications = results as! [VNClassificationObservation]
            
            self.objectNameLbl.text = classifications.first?.identifier.uppercased()
        }
        
    }
    
}
