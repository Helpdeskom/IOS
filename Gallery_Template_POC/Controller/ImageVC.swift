//
//  ImageVC.swift
//  GalleryTemplate_POC
//
//  Created by orange on 04/03/24.
//

import UIKit
import PhotosUI
import TOCropViewController

class ImageVC: UIViewController,  UINavigationControllerDelegate {
    // MARK: - IBOutelts
    @IBOutlet weak var btnSelectImage: UIButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    // MARK: - Properties
    var imageArray = [UIImage]()
    var albumTitle : String = ""
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupCollectionView()
        self.setupUI()
        self.setupAccessibilityIdentifier()
    }
    // MARK: - Functions
    func setupNavigationBar() {
        self.title = "New Print"
        self.navigationController?.navigationBar.accessibilityIdentifier = "navBar"
        // Set navigation right button
        let rightButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        rightButton.accessibilityIdentifier = "btnAdd"
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        // Set navigation left button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteTapped))
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "btnAdd"
    }
    // Action for navigation right button
    @objc func addTapped(_ sender: UIButton) {
        var userIdTextField: UITextField?
        // Alert controller for entering the Title name of the album
        let titleAlert = UIAlertController(title: "Title", message: "Enter a title for your print", preferredStyle: UIAlertController.Style.alert)
        titleAlert.addTextField { (textField) -> Void in
            userIdTextField = textField
            userIdTextField?.placeholder = "Title"
        }
        titleAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true)
        }))
        titleAlert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { (action: UIAlertAction!) in
            self.albumTitle = userIdTextField?.text ?? ""
            let vc = UIStoryboard.init(name: CommonString.mainStoryBoard, bundle: Bundle.main).instantiateViewController(withIdentifier: CommonString.photoLayoutVC) as? PhotoLayoutVC
            vc?.viewModel.albumName = self.albumTitle
            vc?.viewModel.croppedImageArray = self.imageArray
            self.navigationController?.pushViewController(vc!, animated: true)
        }))
        present(titleAlert, animated: true, completion: nil)
    }
    // Action for navigation left button
    @objc func deleteTapped(_ sender : UIButton ) {
        imageArray.removeAll()
        DispatchQueue.main.async {
            self.imageCollectionView.reloadData()
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    // Function for setup collection view
    func setupCollectionView() {
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.registerXib()
    }
    // Function for register XIB
    func registerXib() {
        let registerXib = UINib(nibName: CommonString.imageCollectionCell, bundle: nil)
        self.imageCollectionView.register(registerXib, forCellWithReuseIdentifier: CommonString.imageCollectionCell)
    }
    // Function for setup Accessibility Identifier to UIViews
    func setupAccessibilityIdentifier() {
        self.imageCollectionView.accessibilityIdentifier = "imageCollectionView"
        self.btnSelectImage.accessibilityIdentifier = "btnSelectImage"
//        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "btnAdd"
        self.navigationItem.leftBarButtonItem?.accessibilityIdentifier = "btnDelete"
    }
    // Function for Opening the PHPicker
    func openPHPicker() {
        var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        phPickerConfig.selectionLimit = 500
        phPickerConfig.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
        phPickerVC.delegate = self
        phPickerVC.isEditing = true
        present(phPickerVC, animated: true)
    }
    // Function for UI Setup
    func setupUI() {
        self.btnSelectImage.backgroundColor = .white
        self.btnSelectImage.cornerRadius = self.btnSelectImage.frame.height / 2
        self.btnSelectImage.shadowColor = .black
        self.btnSelectImage.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.btnSelectImage.shadowOpacity = 0.5
        self.btnSelectImage.shadowRadius = 2
        self.btnSelectImage.layer.masksToBounds = false
    }
    // MARK: - IBActions
    @IBAction func btnSelectImageAction(_ sender: Any) {
        self.openPHPicker()
    }
}
// MARK: - Extensions for collectionView Delegate and Datasource functions
extension ImageVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonString.imageCollectionCell, for: indexPath) as? ImageCollectionCell else {
            return UICollectionViewCell()
        }
        cell.imageViewPhotos.image = imageArray[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Open crop viewController for selected image
        let cropController:TOCropViewController = TOCropViewController(image: imageArray[indexPath.item])
        cropController.delegate = self
        self.present(cropController, animated: true, completion: nil)
    }
}
// MARK: - Extension for PHPickerViewControllerDelegate
extension ImageVC : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: .none)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                
                guard let image = reading as? UIImage, error == nil else { return }
                self.imageArray.append(image)   // Append image in array
               
                DispatchQueue.main.async {
                    self.imageCollectionView.reloadData()   // Reload collectionView
                    if self.imageArray.count > 0 {
                        self.navigationItem.rightBarButtonItem?.isEnabled = true
                    }
                }
//                result.itemProvider.loadFileRepresentation(forTypeIdentifier: "public.image") { [weak self] url, _ in
//                }
            }
        }
        
    }
}
// MARK: - Extension for ToCropViewControllerDelegate Function
extension ImageVC : TOCropViewDelegate , TOCropViewControllerDelegate {
    func cropViewDidBecomeResettable(_ cropView: TOCropView) {
        print("Crop View Did Become Resettable")
    }
    func cropViewDidBecomeNonResettable(_ cropView: TOCropView) {
        print("Crop View Did Become Non Resettable")
    }
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        // Update the selected image in the array
        if let selectedIndexPath = self.imageCollectionView.indexPathsForSelectedItems?.first {
            imageArray[selectedIndexPath.item] = image
            DispatchQueue.main.async {
                self.imageCollectionView.reloadItems(at: [selectedIndexPath])   // Reload CollectionView
            }
        }
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
}
