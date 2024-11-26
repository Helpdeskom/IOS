//
//  UserDataTableCell.swift
//  BaseCode
//
//  Created by orange on 27/03/24.
//

import UIKit
import CoreData

class UserDataTableCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var technologyLbl: UILabel!
    @IBOutlet weak var empidLbl: UILabel!
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - Function for ui setup
    func setupData(data: NSManagedObject) {
        self.nameLbl.text = data.value(forKey: "name") as? String
        self.emailLbl.text = data.value(forKey: "email") as? String
        self.empidLbl.text = data.value(forKey: "empid") as? String
        self.technologyLbl.text = data.value(forKey: "technology") as? String
    }
}
