//
//  ItemDetail.swift
//  BaseCode
//
//  Created by orange on 30/04/24.
//

import Foundation
import RealmSwift
// MARK: - Model for ItemDetails
class ItemDetailsModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var isFav: Bool = false
    @objc dynamic var itemCount: Int = 0
    @objc dynamic var imageName: String = ""
    // Initialiser
    override init() {
        super.init()
    }
    // Default initialiser
    init(id: Int, name: String, price: Int, type: String, isFav: Bool, itemCount: Int, imageName: String) {
        self.id = id
        self.name = name
        self.price = price
        self.type = type
        self.isFav = isFav
        self.itemCount = itemCount
        self.imageName = imageName
    }
}
let foodItems: [ItemDetailsModel] = [
    ItemDetailsModel(id: 0, name: "Pizza", price: 10, type: "Veg", isFav: false, itemCount: 0, imageName: "pizza"),
    ItemDetailsModel(id: 1, name: "Burger", price: 8, type: "Non-Veg", isFav: false, itemCount: 0, imageName: "burger"),
    ItemDetailsModel(id: 2, name: "Pasta", price: 12, type: "Veg", isFav: false, itemCount: 0, imageName: "pasta"),
    ItemDetailsModel(id: 3, name: "Salad", price: 6, type: "Veg", isFav: false, itemCount: 0, imageName: "salad"),
    ItemDetailsModel(id: 4, name: "French Fries", price: 5, type: "Veg", isFav: false, itemCount: 0, imageName: "frenchFries"),
    ItemDetailsModel(id: 5, name: "Chicken Wings", price: 9, type: "Non-Veg", isFav: false, itemCount: 0, imageName: "chicken"),
    ItemDetailsModel(id: 6, name: "Paneer", price: 4, type: "Veg", isFav: false, itemCount: 0, imageName: "paneer"),
    ItemDetailsModel(id: 7, name: "Cake", price: 15, type: "Veg", isFav: false, itemCount: 0, imageName: "cake"),
    ItemDetailsModel(id: 8, name: "Sushi", price: 18, type: "Non-Veg", isFav: false, itemCount: 0, imageName: "sushi"),
    ItemDetailsModel(id: 9, name: "Tacos", price: 10, type: "Non-Veg", isFav: false, itemCount: 0, imageName: "tacos"),
    ItemDetailsModel(id: 10, name: "Burrito", price: 10, type: "Non-Veg", isFav: false, itemCount: 0, imageName: "burrito"),
    ItemDetailsModel(id: 11, name: "Smoothie", price: 7, type: "Veg", isFav: false, itemCount: 0, imageName: "smoothie"),
    ItemDetailsModel(id: 12, name: "Milkshake", price: 6, type: "Veg", isFav: false, itemCount: 0, imageName: "milkshake"),
    ItemDetailsModel(id: 13, name: "Fried Rice", price: 11, type: "Non-Veg", isFav: false, itemCount: 0, imageName: "firedRice"),
    ItemDetailsModel(id: 14, name: "Spring Rolls", price: 8, type: "Veg", isFav: false, itemCount: 0, imageName: "springRoll")
]
