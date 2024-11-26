//
//  FaceDetectionViewController.swift
//  BaseCode
//
//  Created by orange on 23/04/24.
//

import UIKit
import ARKit

class FaceDetectionViewController: UIViewController {
    // Constants for plane dimensions, positions, and other parameters
    private let planeWidth: CGFloat = 0.13
    private let planeHeight: CGFloat = 0.06
    let nodeYPosition: Float = 0.022
    let minPositionDistance: Float = 0.0025
    let minscaling: CGFloat = 0.025
    let cellIdentifire = "GlassesCollectionViewCell"
    let cornerRadius: CGFloat = 10
    let animationDuration: TimeInterval = 0.25
    var glassPlane: SCNPlane = SCNPlane(width: 0, height: 0)
    let glassesImages = ["glasses0", "glasses1", "glasses2", "glasses3", "glasses4", "glasses5"]
    
    // Outlets from the storyboard
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var glassesView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var calibrationView: UIView!
    @IBOutlet weak var calibrationTransparentView: UIView!
    @IBOutlet weak var collectionBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var calibrationBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionButton: UIButton!
    @IBOutlet weak var calibrationButton: UIButton!
    @IBOutlet weak var alertLabel: UILabel!
    
    // Node to hold glasses in the AR scene
    private let glassesNode = SCNNode()
    private var scaling: CGFloat = 1
    
    // Flags to track collection and calibration view states
    private var isCollectionOpened = false {
        didSet {
            updateCollectionPostion()
        }
    }
    
    // Flags to track calibration view states
    private var isCalibrationOpened = false {
        didSet {
            updateCalibrationPosition()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the scene view
        sceneView.backgroundColor = .clear
        calibrationView.backgroundColor = .clear
        guard ARFaceTrackingConfiguration.isSupported else {
        alertLabel.text = "Face tracking is not supported on this device"
        return
        }
        self.glassPlane = SCNPlane(width: planeWidth, height: planeHeight)
        sceneView.delegate = self
        setUpCollectionView()
        setUpCalibrationView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        // Start AR face tracking
         let configuration = ARFaceTrackingConfiguration()
         sceneView.session.run(configuration)
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         // Pause AR session
         sceneView.session.pause()
     }
    
    // Collection view setup
    func setUpCollectionView() {
        glassesView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionBottomConstraint.constant = -glassesView.bounds.size.height
    }
    
    // Calibration view setup
    private func setUpCalibrationView() {
        calibrationTransparentView.layer.cornerRadius = cornerRadius
        calibrationBottomConstraint.constant = -calibrationView.bounds.size.height
    }
    
    // To Update glasses image when we click on glasses
    private func updateGlasses(with index: Int) {
        let imageName = glassesImages[index]
        glassPlane.firstMaterial?.diffuse.contents = UIImage(named: imageName)
    }
    
    // Update collection view position
    private func updateCollectionPostion() {
        collectionBottomConstraint.constant = isCollectionOpened ? 0 : -glassesView.bounds.size.height
        UIView.animate(withDuration: animationDuration) {
            self.calibrationButton.alpha = self.isCollectionOpened ? 0 : 1
            self.view.layoutIfNeeded()
        }
    }
    
    // Update calibration view position
    private func updateCalibrationPosition() {
        calibrationBottomConstraint.constant = isCalibrationOpened ? 0 : -calibrationView.bounds.size.height
        UIView.animate(withDuration: animationDuration) {
            self.collectionButton.alpha = self.isCalibrationOpened ? 0 : 1
            self.view.layoutIfNeeded()
        }
    }
    
    // To Update glasses size when we click on bigger Tapped & smaller Tapped
    func updateSize() {
        glassPlane.width = scaling * planeWidth
        glassPlane.height = scaling * planeHeight
    }

    // Action methods for UI buttons
    @IBAction func collectionTapped(_ sender: Any) {
        isCollectionOpened = !isCollectionOpened
    }
    
    @IBAction func calibrationTapped(_ sender: Any) {
        isCalibrationOpened = !isCalibrationOpened
    }
    
    @IBAction func sceneARTapped(_ sender: Any) {
        isCollectionOpened = false
        isCalibrationOpened = false
    }
    
    // Methods to move glasses in AR scene
    @IBAction func topTapped(_ sender: Any) {
        glassesNode.position.y += minPositionDistance
    }
    
    @IBAction func downTapped(_ sender: Any) {
        glassesNode.position.y -= minPositionDistance
    }
    
    @IBAction func rightTapped(_ sender: Any) {
        glassesNode.position.x += minPositionDistance
    }
    
    @IBAction func leftTapped(_ sender: Any) {
        glassesNode.position.x -= minPositionDistance
    }
    
    @IBAction func farTapped(_ sender: Any) {
        glassesNode.position.z += minPositionDistance
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        glassesNode.position.z -= minPositionDistance
    }
    
    @IBAction func biggerTapped(_ sender: Any) {
        scaling += minscaling
        updateSize()
    }
    
    @IBAction func smallerTapped(_ sender: Any) {
        scaling -= minscaling
        updateSize()
    }
    
}

//MARK: -  Extension for ARSCN viewcontroller Delegate
extension FaceDetectionViewController: ARSCNViewDelegate {
    // This method is called when ARKit needs to create a node for a new face anchor.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        // Check if the device is available
        guard let device = sceneView.device else {
            return nil
        }
        // Create a face geometry using the device's metal device
        let faceGeometry = ARSCNFaceGeometry(device: device)
        // Create a new SCNNode with the face geometry
        let faceNode = SCNNode(geometry: faceGeometry)
        // Set transparency of the face geometry to 0 to make it invisible
        faceNode.geometry?.firstMaterial?.transparency = 0
        // Configure the glasses material
        glassPlane.firstMaterial?.isDoubleSided = true
        glassPlane.firstMaterial?.diffuse.contents = UIImage(named: "glasses0")
        // Position the glasses node relative to the face bounding box
        glassesNode.position.z = faceNode.boundingBox.max.z * 3 / 4
        glassesNode.position.y = nodeYPosition
        glassesNode.geometry = glassPlane
        // Add the glasses node as a child node to the face node
        faceNode.addChildNode(glassesNode)
        // Return the face node with the attached glasses node
        return faceNode
    }
    
    // This method is called when ARKit updates an existing face anchor.
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // Check if the anchor is an ARFaceAnchor and the node's geometry is an ARSCNFaceGeometry
        guard let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
            return
        }
        // Update the face geometry with the new geometry from the face anchor
        faceGeometry.update(from: faceAnchor.geometry)
    }
}

//MARK: - Collection view Delegate and Data source Method
extension FaceDetectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // Returns the number of glasses items in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return glassesImages.count
    }
    
    // Configures and returns a cell for the glasses collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifire, for: indexPath) as! GlassesCollectionViewCell
        // Generate the image name based on the current index path
        let imageName = glassesImages[indexPath.row]
        // Set up the cell with the corresponding glasses image
        cell.setUp(with: imageName)
        return cell
    }
    
    // Handles the selection of a glasses item in the collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Update the glasses displayed on the face with the selected glasses item
        updateGlasses(with: indexPath.row)
    }
}
