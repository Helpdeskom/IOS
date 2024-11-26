//
//  ShowDataVC.swift
//  BaseCode
//
//  Created by orange on 27/03/24.
//

import UIKit
import CoreData

class ShowDataVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var userDataTableView: UITableView!
    
    // MARK: - Properties
    private var userDataDict : [NSManagedObject] = []
    private var viewModel = UserDetailsVM()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userDataDict = self.viewModel.fetchData(entityName: "EmployeData")
        self.setupNavigationBar()
        self.setupTableView()
        print("User data is :- \(userDataDict)")
    }
    // function for navigation bar setup
    private func setupNavigationBar() {
        self.navigationItem.title = "Employee Data"
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
        self.navigationItem.rightBarButtonItem = deleteButton
        
    }
    // function for delete button tapped
    @objc func deleteButtonTapped() {
        print("Delete button tapped")
        self.viewModel.deleteAllData(entityName: "EmployeData")
        userDataDict = viewModel.fetchData(entityName: "EmployeData")
        userDataTableView.reloadData()
    }
    
    // MARK: - Function
    private func setupTableView() {
        self.userDataTableView.delegate = self
        self.userDataTableView.dataSource = self
        self.registerTableCell()
    }
    // function for register cell on the tableView
    private func registerTableCell() {
        let registerCell = UINib(nibName: "UserDataTableCell", bundle: nil)
        self.userDataTableView.register(registerCell, forCellReuseIdentifier: "UserDataTableCell")
    }
    
}

// MARK: - Extension for tableView Delegate and Datasource
extension ShowDataVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataDict.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataTableCell", for: indexPath) as? UserDataTableCell  else {
            return UITableViewCell()
        }
        cell.setupData(data: userDataDict[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let userId = userDataDict[indexPath.row].value(forKey: "empid") as? Int ?? 0
            _ = userDataDict.remove(at: indexPath.row)
            self.viewModel.deleteData(entityName: "EmployeData", userId : userId )
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.view.showToast(message: "Data Deleted successfully")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateUserDetailsVC") as! UpdateUserDetailsVC
        let navVc = UINavigationController(rootViewController: vc)
        vc.delegate = self
        vc.userDataDict = userDataDict[indexPath.row]
        self.present(navVc, animated: true, completion: nil)  
    }
}
// MARK: - Extension for dismiss View Controller call back
extension ShowDataVC : VCDismissDelegate {
    func vcDismissedCallBack() {
        print("VC Dismissed call back here ")
        userDataDict = viewModel.fetchData(entityName: "EmployeData")
        userDataTableView.reloadData()
    }
    
}
