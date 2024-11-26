//
//  CartVC.swift
//  BaseCode
//
//  Created by orange on 30/04/24.
//

import UIKit
import RealmSwift
class CartVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var cartTableView: UITableView!
    // MARK: - Properties
    let realmManager = RealmManager<ItemDetailsModel>()
    var cartItems: Results<ItemDetailsModel>?
    weak var delegate: UpdateItemDataProtocol?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
        // This predicate is for getting the object which contains itemCount more than 0.
        let predicate = NSPredicate(format: "itemCount > 0")
        self.cartItems = realmManager.retrieve(with: predicate)
        if let cartItems = self.cartItems {
            for item in cartItems {
                print(item)
            }
        }
    }
    // MARK: - Functions
    func setupUI() {
        self.lblTitle.text = "My Cart"
        self.btnBack.setTitle("", for: .normal)
        self.viewNavigation.layer.cornerRadius = 16
    }
    // function for tableView setup
    func setupTableView() {
        self.cartTableView.dataSource = self
        self.cartTableView.delegate = self
        self.registerXib()
    }
    // Function for register XIB
    func registerXib() {
        let registerXIB = UINib(nibName: "CartTableCell", bundle: nil)
        self.cartTableView.register(registerXIB, forCellReuseIdentifier: "CartTableCell")
    }
    // MARK: - IBAction
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK: - Extension for TableView Delegate and Datasource function.
extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartItems?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableCell", for: indexPath) as? CartTableCell else {
            return UITableViewCell()
        }
        cell.setupData(itemData: self.cartItems?[indexPath.row] ?? ItemDetailsModel())
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let selectedItem = cartItems?[indexPath.row] else {
            return
        }
        // Update the itemCount of the selected item to 0
        let updatedProperties: [String: Any] = ["itemCount": 0]
        realmManager.update(object: selectedItem, with: updatedProperties)
        self.delegate?.updateData()
        // Reload the corresponding row in the tableView
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
