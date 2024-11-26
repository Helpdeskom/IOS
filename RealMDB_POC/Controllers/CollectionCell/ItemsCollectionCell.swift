//
//  ItemsCollectionCell.swift
//  BaseCode
//
//  Created by orange on 30/04/24.
//

import UIKit
import RealmSwift
class ItemsCollectionCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var productTypeImg: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productCountBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    // MARK: - Properties
    var itemCount = 0
    var isFav: Bool = false
    let realmManager = RealmManager<ItemDetailsModel>()
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    // MARK: - Functions
    func setupUI() {
        self.plusBtn.setTitle("", for: .normal)
        self.minusBtn.setTitle("", for: .normal)
        self.favBtn.setTitle("", for: .normal)
        self.plusBtn.isHidden = true
        self.minusBtn.isHidden = true
        self.productCountBtn.setTitle("Add", for: .normal)
        self.productTypeImg.layer.cornerRadius = self.productTypeImg.frame.width / 2
        self.productCountBtn.titleLabel?.font = UIFont.systemFont(ofSize: 8.0, weight: .semibold)
    }
    // function for setting up data on the HomeScreen
    func setupData(foodData: ItemDetailsModel) {
        self.productNameLbl.text = foodData.name
        self.productPriceLbl.text = "₹ " + String(foodData.price)
        self.productImg.image = UIImage(named: foodData.imageName )
        if foodData.type == "Veg" {
            self.productTypeImg.backgroundColor = UIColor.green
        } else {
            self.productTypeImg.backgroundColor = UIColor.red
        }
        self.favBtn.setImage(foodData.isFav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        self.isFav = foodData.isFav
        if foodData.itemCount > 0 {
            self.productCountBtn.setTitle(String(foodData.itemCount), for: .normal)
            self.plusBtn.isHidden = false
            self.minusBtn.isHidden = false
        } else {
            self.productCountBtn.setTitle("Add", for: .normal)
            self.plusBtn.isHidden = true
            self.minusBtn.isHidden = true
        }
        self.itemCount = foodData.itemCount
    }
    // function for setting up data on the Favourite Screen
    func setupDataForFav(itemData: ItemDetailsModel) {
        self.productNameLbl.text = itemData.name
        self.productPriceLbl.text = "₹ " + String(itemData.price)
        self.productImg.image = UIImage(named: itemData.imageName )
        if itemData.type == "Veg" {
            self.productTypeImg.backgroundColor = UIColor.green
        } else {
            self.productTypeImg.backgroundColor = UIColor.red
        }
        self.favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        self.isFav = itemData.isFav
    }
    // Function for increase count
    func increaseCount() {
        self.itemCount += 1
    }
    // Function for Decrease count
    func decreaseCount() {
        self.itemCount -= 1
    }
    // MARK: - IBAction
    @IBAction func btnPlusAction(_ sender: UIButton) {
        self.increaseCount()
        productCountBtn.setTitle(String(self.itemCount), for: .normal)
        self.addItemToCart(tag: sender.tag)
    }
    @IBAction func btnMinusAction(_ sender: UIButton) {
        self.decreaseCount()
        productCountBtn.setTitle(String(self.itemCount), for: .normal)
        self.addItemToCart(tag: sender.tag)
        if self.itemCount == 0 {
            productCountBtn.setTitle("Add", for: .normal)
            self.plusBtn.isHidden = true
            self.minusBtn.isHidden = true
            self.productCountBtn.isUserInteractionEnabled = true
            // Write code for remove the item
        } else {
            // Write code for adding the item
        }
    }
    @IBAction func btnProductCountAction(_ sender: UIButton) {
        self.increaseCount()
        self.addItemToCart(tag: sender.tag)
        plusBtn.isHidden = false
        minusBtn.isHidden = false
        productCountBtn.isUserInteractionEnabled = false
        productCountBtn.setTitle(String(self.itemCount), for: .normal)
    }
    @IBAction func btnFavAction(_ sender: UIButton) {
        self.isFav.toggle()
        favBtn.setImage(self.isFav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        let itemId = sender.tag
        let predicate = NSPredicate(format: "id == %d", itemId)
        let selectedItems = realmManager.retrieve(with: predicate)
        guard let selectedItem = selectedItems.first else {
            print("Item with ID \(itemId) not found.")
            return
        }
        realmManager.update(object: selectedItem, with: ["isFav": self.isFav])
    }
    // Function for Add item in the cart
    func addItemToCart(tag: Int) {
        let itemId = tag
        let predicate = NSPredicate(format: "id == %ld", itemId)
        let selectedItems = realmManager.retrieve(with: predicate)
        guard let selectedItem = selectedItems.first else {
            print("Item with ID \(itemId) not found.")
            return
        }
        // Update the object with the new item count
        let propertiesToUpdate: [String: Any] = ["itemCount": self.itemCount]
        realmManager.update(object: selectedItem, with: propertiesToUpdate)
    }
}
