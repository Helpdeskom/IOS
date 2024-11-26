//
//  LayoutVM.swift
//  GalleryTemplate_POC
//
//  Created by orange on 13/03/24.
//

import Foundation
import UIKit

class LayoutVM {
    // MARK: - Properties
    var layoutData : [LayoutModel] = [
        LayoutModel(numberOfImage: 1, sectionIndex: 0, imageType: UIImage(named: "layout1") ?? UIImage(), layoutType: LayoutType.layout1.compositionalLayout()),
        LayoutModel(numberOfImage: 2, sectionIndex: 1, imageType: UIImage(named: "layout2") ?? UIImage(), layoutType: LayoutType.layout2.compositionalLayout()),
        LayoutModel(numberOfImage: 4, sectionIndex: 2, imageType: UIImage(named: "layout3") ?? UIImage(), layoutType: LayoutType.layout3.compositionalLayout()),
        LayoutModel(numberOfImage: 2, sectionIndex: 3, imageType: UIImage(named: "layout4") ?? UIImage(), layoutType: LayoutType.layout4.compositionalLayout()),
        LayoutModel(numberOfImage: 3, sectionIndex: 4, imageType: UIImage(named: "layout5") ?? UIImage(), layoutType: LayoutType.layout5.compositionalLayout()),
        LayoutModel(numberOfImage: 3, sectionIndex: 5, imageType: UIImage(named: "layout6") ?? UIImage(), layoutType: LayoutType.layout6.compositionalLayout()),
        LayoutModel(numberOfImage: 3, sectionIndex: 6, imageType: UIImage(named: "layout7") ?? UIImage(), layoutType: LayoutType.layout7.compositionalLayout()),
        LayoutModel(numberOfImage: 3, sectionIndex: 7, imageType: UIImage(named: "layout8") ?? UIImage(), layoutType: LayoutType.layout8.compositionalLayout()),
        LayoutModel(numberOfImage: 3, sectionIndex: 8, imageType: UIImage(named: "layout9") ?? UIImage(), layoutType: LayoutType.layout9.compositionalLayout()),
        LayoutModel(numberOfImage: 3, sectionIndex: 9, imageType: UIImage(named: "layout10") ?? UIImage(), layoutType: LayoutType.layout10.compositionalLayout()),
        LayoutModel(numberOfImage: 4, sectionIndex: 10,imageType: UIImage(named: "layout11") ?? UIImage(), layoutType: LayoutType.layout11.compositionalLayout()),
    ]
}
