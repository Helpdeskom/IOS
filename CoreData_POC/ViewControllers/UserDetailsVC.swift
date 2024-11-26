//
//  UserDetailsVC.swift
//  BaseCode
//
//  Created by orange on 27/03/24.
//

import UIKit

class UserDetailsVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var empIdTextField: UITextField!
    @IBOutlet weak var technologyTextField: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnShowData: UIButton!
    // MARK: - Properties
    private var viewModel = UserDetailsVM()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    // MARK: - Functions
    private func setupUI() {
    }
    // MARK: - IBActions
    @IBAction func btnSaveAction(_ sender: Any) {
        guard let empName = self.nameTextField.text, !empName.isEmpty else {
            return self.view.showToast(message: "Emp name should not be empty")
        }
        guard let empEmail = self.emailTextField.text, !empEmail.isEmpty else {
            return self.view.showToast(message: "Emp email should not be empty")
        }
        guard let empid = self.empIdTextField.text, !empid.isEmpty else {
            return self.view.showToast(message: "Emp id should not be empty")
        }
        guard let empTech = self.technologyTextField.text, !empTech.isEmpty else {
            return self.view.showToast(message: "Emp tech should not be empty")
        }
        self.viewModel.saveData(entityName: "EmployeData", attributeData: ["name":empName, "email": empEmail, "empid": Int(empid) ?? 0, "technology": empTech])
        // For removing the text
        self.emailTextField.text = ""
        self.nameTextField.text = ""
        self.empIdTextField.text = ""
        self.technologyTextField.text = ""
    }
        @IBAction func btnShowDataAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShowDataVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
