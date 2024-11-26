//
//  ViewController.swift
//  BaseCode
//
//  Created by Orange Mantra on 15/11/21.
//

import UIKit
import RealmSwift
import Alamofire
class HomeVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    // MARK: - Properties
    let realmManager = RealmManager<ItemDetailsModel>()
    var object = ItemDetailsModel()
    var itemArray: [ItemDetailsModel]?
    var realmDB: Realm!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.setupNavigationView()
        self.setupCollectionView()
        // For getting the Realm File Path so that we can open in the RealmStudio
        /*
         - Download Realm Studio in MAC
         - Open terminal and write open realmFilePath
         */
        do {
            realmDB = try Realm()
        } catch {
            print("Error initializing Realm database: \(error)")
        }
        print(realmDB.configuration.fileURL!)
        itemArray = Array(realmManager.retrieveAll())
        // Checking the data in DB. if any update occur, it will fetch the updated data.
        for item in foodItems where !(itemArray?.contains(where: {$0.id == item.id}) ?? false) {
            itemArray?.append(item)
            realmManager.create(object: item)
        }
    }
        // MARK: - Functions
    func setupNavigationView() {
        self.titleLbl.text = "Home"
        self.cartBtn.setTitle("", for: .normal)
        self.favoriteBtn.setTitle("", for: .normal)
        self.navigationView.layer.cornerRadius = 16
    }
    // Function for collectionview setup
    func setupCollectionView() {
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        self.registerXIB()
    }
    // Function for register XIB
    func registerXIB() {
        let registerXib = UINib(nibName: "ItemsCollectionCell", bundle: nil)
        self.mainCollectionView.register(registerXib, forCellWithReuseIdentifier: "ItemsCollectionCell")
    }
    // MARK: - IBActions
    @IBAction func btnFavoriteAction(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "FavouriteVC") as? FavouriteVC else {
            return
        }
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnCartAction(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "CartVC") as? CartVC else {
            return
        }
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - Extension for CollectionView Delegate and Datasource Functions
extension HomeVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCollectionCell", for: indexPath) as? ItemsCollectionCell else {
            return UICollectionViewCell()
        }
        cell.setupData(foodData: itemArray?[indexPath.row] ?? ItemDetailsModel())
        cell.favBtn.tag = itemArray?[indexPath.row].id ?? 0
        cell.plusBtn.tag = itemArray?[indexPath.row].id ?? 0
        cell.minusBtn.tag = itemArray?[indexPath.row].id ?? 0
        cell.productCountBtn.tag = itemArray?[indexPath.row].id ?? 0
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
// MARK: - Extension for update Data Protocol
extension HomeVC: UpdateItemDataProtocol {
    func updateData() {
        self.itemArray = Array(realmManager.retrieveAll())
        self.mainCollectionView.reloadData()
    }
}
