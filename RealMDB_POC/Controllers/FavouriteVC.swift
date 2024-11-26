//
//  FavouriteVC.swift
//  BaseCode
//
//  Created by orange on 30/04/24.
//

import RealmSwift
import UIKit
// Protocol for updating the Data
protocol UpdateItemDataProtocol: AnyObject {
    func updateData()
}

class FavouriteVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var favCollectionView: UICollectionView!
    // MARK: - Properties
    let realmManager = RealmManager<ItemDetailsModel>()
    var favItems: Results<ItemDetailsModel>?
    weak var delegate: UpdateItemDataProtocol?
        // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupCollectionView()
        // Predicate is used for applying the particular condition
        let predicate = NSPredicate(format: "isFav == true")
        favItems = realmManager.retrieve(with: predicate)
        if let favItems = favItems {
            for item in favItems {
                print(item)
            }
        }
    }
    // MARK: - Functions
    func setupUI() {
        self.lblTitle.text = "My Favourite"
        self.btnBack.setTitle("", for: .normal)
        self.viewNavigation.layer.cornerRadius = 16
    }
    // function for collection view setup
    func setupCollectionView() {
        self.favCollectionView.dataSource = self
        self.favCollectionView.delegate = self
        self.registerXIB()
    }
    // Function for register XIB
    func registerXIB() {
        let registerXIB = UINib(nibName: "ItemsCollectionCell", bundle: nil)
        self.favCollectionView.register(registerXIB, forCellWithReuseIdentifier: "ItemsCollectionCell")
    }
    // MARK: - IBAction
    @IBAction func btnBackAction(_ sender: Any) {
        self.delegate?.updateData()
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK: - Extension for UICollection View Delegate and datasource functions
extension FavouriteVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favItems?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCollectionCell", for: indexPath) as? ItemsCollectionCell else {
            return UICollectionViewCell()
        }
        cell.setupDataForFav(itemData: self.favItems?[indexPath.row] ?? ItemDetailsModel() )
        cell.favBtn.tag = favItems?[indexPath.row].id ?? 0
        cell.minusBtn.tag = favItems?[indexPath.row].id ?? 0
        cell.plusBtn.tag = favItems?[indexPath.row].id ?? 0
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing: CGFloat = 0
        let numberOfItemsPerRow: CGFloat = 3
        let totalSpacing = (numberOfItemsPerRow - 1) * spacing
        let itemWidth = (collectionViewWidth - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: itemWidth, height: 160)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
