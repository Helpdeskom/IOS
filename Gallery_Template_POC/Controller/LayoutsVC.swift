//
//  LayoutsVC.swift
//  GalleryTemplate_POC
//
//  Created by orange on 04/03/24.
//

import UIKit
// MARK: - Protocol for getting call back after the layout dismiss
protocol layoutDismissedDelegate : AnyObject {
    func layoutDismissedCallBack(itemSelectedIndex : Int, numberOfImage : Int, layoutType: NSCollectionLayoutSection)
}
// Class
class LayoutsVC: UIViewController {
    // MARK: - IBoutlets
    @IBOutlet weak var layoutCollectionView: UICollectionView!
    // MARK: - Properties
    private var viewModel = LayoutVM()
    weak var delegate : layoutDismissedDelegate?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Page Template"
        self.setupCollectionView()
    }
    // MARK: - Functions
    // Function for collection view Setup
    func setupCollectionView() {
        self.layoutCollectionView.delegate = self
        self.layoutCollectionView.dataSource = self
        self.registerXib()
        self.layoutCollectionView.accessibilityIdentifier = "layoutCollectionView"
    }
    // Function for register XIB
    func registerXib() {
        let registerXib = UINib(nibName: CommonString.layoutsCollectionCell, bundle: nil)
        self.layoutCollectionView.register(registerXib, forCellWithReuseIdentifier:  CommonString.layoutsCollectionCell)
    }
}
// MARK: - Extension for collectionView Delegate and DataSource function
extension LayoutsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.layoutData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  CommonString.layoutsCollectionCell, for: indexPath) as? LayoutsCollectionCell else {
            return UICollectionViewCell()
        }
        cell.layoutImageView.image = viewModel.layoutData[indexPath.item].imageType
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 3
        return CGSize(width: width, height: width)
    }
    // write action for any item selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.delegate?.layoutDismissedCallBack(itemSelectedIndex: self.viewModel.layoutData[indexPath.item].sectionIndex , numberOfImage: self.viewModel.layoutData[indexPath.item].numberOfImage, layoutType: self.viewModel.layoutData[indexPath.item].layoutType)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
