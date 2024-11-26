//
//  HeaderViewForSection.swift
//  GalleryTemplate_POC
//
//  Created by orange on 05/03/24.
//

import UIKit

class HeaderViewForSection: UICollectionReusableView {
    // MARK: - IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnChangeLayout: UIButton!
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }
        // MARK: - Function for UI setup
    func setupUI() {
        btnChangeLayout.cornerRadius = 10
        btnChangeLayout.backgroundColor = .lightGray
        
    }
}
