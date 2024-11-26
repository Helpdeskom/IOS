//
//  CartTableCell.swift
//  BaseCode
//
//  Created by orange on 01/05/24.
//

import UIKit
class CartTableCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnITemCount: UIButton!
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    // MARK: - Functions
    func setupUI() {
        btnMinus.isHidden = true
        btnPlus.isHidden = true
        btnITemCount.setTitle("0", for: .normal)
        btnPlus.setTitle("", for: .normal)
        btnMinus.setTitle("", for: .normal)
    }
    // function for setup data on the UI
    func setupData(itemData: ItemDetailsModel) {
        self.imgItem.image = UIImage(named: itemData.imageName)
        self.lblItemName.text = itemData.name
        self.lblItemPrice.text =  "₹ " + String(itemData.price)
        self.btnITemCount.setTitle(String(itemData.itemCount), for: .normal)
    }
}
