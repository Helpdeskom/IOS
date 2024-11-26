//
//  UpdateUserDetailsVC.swift
//  BaseCode
//
//  Created by orange on 28/03/24.
//

import UIKit
import CoreData
// MARK: - Protocol for call back of Dismiss View Controller
protocol VCDismissDelegate : AnyObject {
    func vcDismissedCallBack()
}
class UpdateUserDetailsVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var nameTetField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var technologyTextField: UITextField!
    @IBOutlet weak var empidTextField: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    // MARK: - Properties
    weak var delegate : VCDismissDelegate?
    private var viewModel = UserDetailsVM()
    private var empId : Int? = 0
    var userDataDict: NSManagedObject?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupUI()
    }
    // MARK: - Functions
    private func setupNavigationBar() {
        self.navigationItem.title = "Update Data"
    }
    private func setupUI() {
        if let name = userDataDict?.value(forKey: "name") as? String {
            self.nameTetField.text = name
        } else {}
        if let email = userDataDict?.value(forKey: "email") as? String {
            self.emailTextField.text = email
        } else {}
        if let empid = userDataDict?.value(forKey: "empid") as? Int {
            self.empId = empid
            self.empidTextField.text = String(empid)
        } else {}
        if let tech = userDataDict?.value(forKey: "technology") as? String {
            self.technologyTextField.text = tech
        } else {}
    }
    // MARK: - IBActions
    @IBAction func btnSaveAction(_ sender: Any) {
        guard let empName = self.nameTetField.text, !empName.isEmpty else {
            return self.view.showToast(message: "Emp name should not be empty")
        }
        guard let empEmail = self.emailTextField.text, !empEmail.isEmpty else {
            return self.view.showToast(message: "Emp email should not be empty")
        }
        guard let empid = self.empidTextField.text, !empid.isEmpty else {
            return self.view.showToast(message: "Emp id should not be empty")
        }
        guard let empTech = self.technologyTextField.text, !empTech.isEmpty else {
            return self.view.showToast(message: "Emp tech should not be empty")
        }
        self.viewModel.updateData(entityName: "EmployeData", userId: self.empId ?? 0, updatedName: empName, updatedEmail: empEmail, updatedEmpId: Int(empid) ?? 0, updatedTech: empTech)
        self.view.showToast(message: "Data Updated Successfully")
        self.dismiss(animated: true) {
            self.delegate?.vcDismissedCallBack()
        }
    }
}
