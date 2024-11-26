//
//  PhotoLayoutVC.swift
//  GalleryTemplate_POC
//
//  Created by orange on 04/03/24.
//

import UIKit

class PhotoLayoutVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var collageCollectionView: UICollectionView!
    // MARK: - Properties
    var viewModel = PhotoLayoutVM()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigatioBar()
        self.setupCollectionView()
        self.setupAccessibilityIdentifier()
    }
    // MARK: - Functions
    // Function for setup navigation bar
    func setupNavigatioBar() {
        self.navigationItem.title = viewModel.albumName
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Print", style: .plain, target: self, action: #selector(printTapped))
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "printBtn"
    }
    // Function for collection view setup
    func setupCollectionView() {
        self.collageCollectionView.delegate = self
        self.collageCollectionView.dataSource = self
        self.registerXib()
        self.collageCollectionView.collectionViewLayout = createCompostionalLayouts()
    }
    // Function for setup accessibility identifiers
    func setupAccessibilityIdentifier() {
        self.collageCollectionView.accessibilityIdentifier = "collageCollectionView"
        self.mainView.accessibilityIdentifier = "mainView"
    }
    // Function for Register XIB
    func registerXib() {
        let registerXib = UINib(nibName: CommonString.photoLayoutCollectionCell, bundle: nil)
        self.collageCollectionView.register(registerXib, forCellWithReuseIdentifier: CommonString.photoLayoutCollectionCell)
        let headerNib = UINib(nibName: CommonString.headerView, bundle: nil)
        self.collageCollectionView.register(headerNib, forSupplementaryViewOfKind: PhotoLayoutVM.headerView , withReuseIdentifier: CommonString.headerView)
    }
    // MARK: - Button Action for PDF Generate
    @objc func printTapped(_ sender: UIButton) {
        let pdfData : NSData = viewModel.PDFWithScrollView(scrollview: collageCollectionView)
        viewModel.savePDFDataAsFile(pdfData: pdfData, fileName: "\(viewModel.albumName).pdf")
    }
}
// MARK: - Extension for collectionView Delegate and datasource Function
extension PhotoLayoutVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.calculateSectionForTableview()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.isInitial {
            let startIndex = section * viewModel.sectionLayouts[4].numberOfImage
            let endIndex = min(startIndex + viewModel.sectionLayouts[4].numberOfImage, viewModel.croppedImageArray.count)
            return endIndex - startIndex
        } else {
            return viewModel.initialLayoutArray[section].numberOfImage
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonString.photoLayoutCollectionCell, for: indexPath) as? PhotoLayoutCollectionCell else {
            return UICollectionViewCell()
        }
        var imageIndex = 0
        if viewModel.isInitial {
            imageIndex = indexPath.section * viewModel.sectionLayouts[4].numberOfImage + indexPath.item
            cell.collageImageView.image = self.viewModel.croppedImageArray[imageIndex]
        } else {
            var currentIndex = 0
            if indexPath.section == 0 {
                currentIndex += indexPath.row
            } else {
                for section in 0..<indexPath.section {
                    currentIndex += viewModel.initialLayoutArray[section].numberOfImage
                }
                currentIndex += indexPath.row
            }
            cell.collageImageView.image = self.viewModel.croppedImageArray[currentIndex]
        }
        return cell
    }
    // CollectionView Compostional Layout Function
    func createCompostionalLayouts() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            if self.viewModel.isInitial {
                return self.viewModel.sectionLayouts[5].layoutType
            } else {
                return self.viewModel.initialLayoutArray[section].layoutType
            }
        }
    }
    // Funtion for header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderViewForSection", for: indexPath) as? HeaderViewForSection  else {
            return UIView() as! UICollectionReusableView
        }
        let sectionCount = indexPath.section + 1
        switch kind {
        case PhotoLayoutVM.headerView :
            header.backgroundColor = UIColor.lightGray
            header.lblTitle.text = "Page \(sectionCount)"
            header.btnChangeLayout.addTarget(self, action: #selector(layoutChange(_:)), for: .touchUpInside)
            header.btnChangeLayout.tag = indexPath.section
        default:
            ()
        }
        return header
    }
    // Button action for change layout button in header
    @objc func layoutChange(_ sender : UIButton) {
        let section = sender.tag
        viewModel.sectionButtonTapped = section
        // Present the Layout VC for choosing the Layout for sections
        let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonString.layoutsVC) as! LayoutsVC
        let navVc = UINavigationController(rootViewController: vc)
        vc.delegate = self
        self.present(navVc, animated: true, completion: nil)
    }
}
// MARK: - Extension for Layout Dismissed Protocol Delegate
extension PhotoLayoutVC : layoutDismissedDelegate {
    func layoutDismissedCallBack(itemSelectedIndex: Int, numberOfImage: Int, layoutType: NSCollectionLayoutSection) {
        self.viewModel.isInitial = false
        print("The initial Layout array before layout selection: \(viewModel.initialLayoutArray)")
        viewModel.initialLayoutArray[viewModel.sectionButtonTapped].layoutType = layoutType
        viewModel.initialLayoutArray[viewModel.sectionButtonTapped].numberOfImage = numberOfImage
        viewModel.initialLayoutArray[viewModel.sectionButtonTapped].sectionIndex = itemSelectedIndex
        var updatedSectionLayouts: [SectionLayoutModel] = []
        var remainingImageCount = viewModel.croppedImageArray.count
        for (_, layout) in viewModel.initialLayoutArray.enumerated() {
            if remainingImageCount >= layout.numberOfImage {
                updatedSectionLayouts.append(layout)
                remainingImageCount -= layout.numberOfImage
            } else {
                break
            }
        }
        while remainingImageCount > 0 {
            let newSectionLayout = SectionLayoutModel(numberOfImage: min(remainingImageCount,2), sectionIndex: updatedSectionLayouts.count, layoutType: LayoutType.layout4.compositionalLayout())
            updatedSectionLayouts.append(newSectionLayout)
            remainingImageCount -= newSectionLayout.numberOfImage
        }
        viewModel.initialLayoutArray = updatedSectionLayouts
        print("The initial Layout array after layout selection: \(viewModel.initialLayoutArray)")
        DispatchQueue.main.async {
            self.collageCollectionView.reloadData()
        }
    }
}
// MARK: - Extension for number of Section calculative functions
extension PhotoLayoutVC {
    func calculateSectionForTableview() -> Int {
        if viewModel.isInitial {
            viewModel.section = Int(ceil(Double(viewModel.croppedImageArray.count) / Double(viewModel.sectionLayouts[4].numberOfImage)))
            if viewModel.section > 0 {
                for _ in 0...(viewModel.section - 1) {
                    viewModel.initialLayoutArray.append(viewModel.sectionLayouts[5])
                }
            } else {
            }
            return viewModel.section
        } else {
            return viewModel.initialLayoutArray.count
        }
    }
}
