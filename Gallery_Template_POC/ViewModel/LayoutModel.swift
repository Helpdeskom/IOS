//
//  LayoutModel.swift
//  GalleryTemplate_POC
//
//  Created by orange on 06/03/24.
//

import Foundation
import UIKit

enum LayoutType {
    // Enum for different layout
    case layout1
    case layout2
    case layout3
    case layout4
    case layout5
    case layout6
    case layout7
    case layout8
    case layout9
    case layout10
    case layout11
    case layout12
    // Function for compositional Layout
    func compositionalLayout() -> NSCollectionLayoutSection {
        switch self {
        case .layout1:
            return CompostionalLayouts.shared.layout1()
        case .layout2:
            return CompostionalLayouts.shared.layout2()
        case .layout3:
            return CompostionalLayouts.shared.layout3()
        case .layout4:
            return CompostionalLayouts.shared.layout4()
        case .layout5:
            return CompostionalLayouts.shared.layout5()
        case .layout6:
            return CompostionalLayouts.shared.layout6()
        case .layout7:
            return CompostionalLayouts.shared.layout7()
        case .layout8:
            return CompostionalLayouts.shared.layout8()
        case .layout9:
            return CompostionalLayouts.shared.layout9()
        case .layout10:
            return CompostionalLayouts.shared.layout10()
        case .layout11:
            return CompostionalLayouts.shared.layout11()
        case .layout12:
            return CompostionalLayouts.shared.layout12()
        }
    }
}
struct SectionLayoutModel {
    var numberOfImage : Int
    var sectionIndex : Int
    var layoutType : NSCollectionLayoutSection    
}
struct LayoutModel {
    var numberOfImage : Int
    var sectionIndex : Int
    var imageType : UIImage
    var layoutType : NSCollectionLayoutSection
}
