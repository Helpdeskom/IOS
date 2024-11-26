//
//  CompostionalLayouts.swift
//  GalleryTemplate_POC
//
//  Created by orange on 05/03/24.
//

import Foundation
import UIKit

class CompostionalLayouts {
    // Singleton object
    static var shared = CompostionalLayouts()
    // MARK: - Layout 1
    func layout1() -> NSCollectionLayoutSection {
        // Items
        let leadingItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1) ,
                heightDimension: .fractionalHeight(1)
            )
        )
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.4)),
            subitems: [leadingItem])
        // HeaderView
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "HeaderView",
                                                                 alignment: .top)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
        // Uncomment this  line is you want to return UICollectionViewCompositionalLayout
//        return UICollectionViewCompositionalLayout(section: section)
    }
    // MARK: - Layout 2
    func layout2() -> NSCollectionLayoutSection {
        // Items
        let leadingItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5) ,
                heightDimension: .fractionalHeight(1)
            )
        )
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let trailingItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5) ,
                heightDimension: .fractionalHeight(1)
            )
        )
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.4)),
            subitems: [leadingItem,trailingItem])
        // HeaderView
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "HeaderView",
                                                                 alignment: .top)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
//         Uncomment this  line is you want to return UICollectionViewCompositionalLayout
//        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Layout 3
    func layout3() -> NSCollectionLayoutSection {
        // Items
        // Leading item
        let leadingItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),  //width 1 bcz uss pertiular group m single item h
            heightDimension: .fractionalHeight(0.5)  //width 1 bcz uss pertiular group m single item h
        )
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        // trailing item
        let trailingItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),   //width 1 bcz uss pertiular group m single item h
            heightDimension: .fractionalHeight(0.5)   //width 1 bcz uss pertiular group m single item h
        )
        let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 0)
        // Leading Group
        let leadingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)),
            repeatingSubitem: trailingItem,
            count: 2
        )
        leadingGroup.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        // Trailing Group
        let trailingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)),
            repeatingSubitem: trailingItem,
            count: 2
        )
        trailingGroup.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
        // Total Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [leadingGroup,trailingGroup])
        // Headerview
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "HeaderView",
                                                                 alignment: .top)
//        Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
//         Uncomment this  line is you want to return UICollectionViewCompositionalLayout
//        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Layout 4
    func layout4() -> NSCollectionLayoutSection {
        // topItem
        let topItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        )
        let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)
        topItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        // Bottom Item
        let bottomItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        )
        let bottomItem = NSCollectionLayoutItem(layoutSize: bottomItemSize)
        bottomItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8)
        // Group
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [topItem,bottomItem])
        // Headerview
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "HeaderView",
                                                                 alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
//         Uncomment this  line is you want to return UICollectionViewCompositionalLayout
//        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Layout 5
    func layout5() -> NSCollectionLayoutSection {
        // Items
        // Leading item
        let leadingItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5) ,
                heightDimension: .fractionalHeight(1)
            )
        )
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        // Trailing item
        let trailingItem = NSCollectionLayoutItem (
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 8)
        // Trailing Group for 2 item in same group
        let trailingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)),
            repeatingSubitem: trailingItem,
            count: 2
        )
        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [leadingItem,trailingGroup])
        // Headerview
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "HeaderView",
                                                                 alignment: .top)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
//         Uncomment this  line is you want to return UICollectionViewCompositionalLayout
//        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Layout 6
    func layout6() -> NSCollectionLayoutSection {
        // Items
        // Leading item
        let trailingItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5) ,
                heightDimension: .fractionalHeight(1)
            )
        )
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 8)
        // Trailing item
        let leadingItem = NSCollectionLayoutItem (
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        // Trailing Group for 2 item in same group
        let leadingItemGroup = NSCollectionLayoutGroup.vertical(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)),
            repeatingSubitem: leadingItem,
            count: 2
        )
        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [leadingItemGroup,trailingItem])
        // Headerview
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "HeaderView",
                                                                 alignment: .top)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
//         Uncomment this  line is you want to return UICollectionViewCompositionalLayout
//        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Layout 7
    func layout7() -> NSCollectionLayoutSection {
        // Items
        // bottom item
        let bottomItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1) ,
                heightDimension: .fractionalHeight(0.5)
            )
        )
        bottomItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        // top item
        let topItem = NSCollectionLayoutItem (
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        topItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        // top Group for 2 item in same group
        let topItemGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)),
            repeatingSubitem: topItem,
            count: 2
        )
        // Group
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [topItemGroup,bottomItem])
        // Headerview
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "HeaderView",
                                                                 alignment: .top)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
//         Uncomment this  line is you want to return UICollectionViewCompositionalLayout
//        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Layout 8
    func layout8() -> NSCollectionLayoutSection {
        // Items
        // bottom item
        let topItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1) ,
                heightDimension: .fractionalHeight(0.5)
            )
        )
        topItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        // top item
        let bottomItem = NSCollectionLayoutItem (
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        bottomItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        // top Group for 2 item in same group
        let bottomItemGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)),
            repeatingSubitem: bottomItem,
            count: 2
        )
        // Group
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [topItem,bottomItemGroup])
        // Headerview
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "HeaderView",
                                                                 alignment: .top)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
//         Uncomment this  line is you want to return UICollectionViewCompositionalLayout
//        return UICollectionViewCompositionalLayout(section: section)
    }

    // MARK: - Layout 9
    func layout9() -> NSCollectionLayoutSection {
        // Items
        let leadingItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.6) ,
                heightDimension: .fractionalHeight(1)
            )
        )
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 4)
        let trailingItem = NSCollectionLayoutItem (
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        // Group
        let trailingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .fractionalHeight(1)),
            repeatingSubitem: trailingItem,
            count: 2
        )
        trailingGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [leadingItem,trailingGroup])
        // Headerview
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "HeaderView",
                                                                 alignment: .top)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
//         Uncomment this  line is you want to return UICollectionViewCompositionalLayout
//        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Layout 10
    func layout10() -> NSCollectionLayoutSection {
        // Items
        let trailingItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.6) ,
                heightDimension: .fractionalHeight(1)
            )
        )
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
        let leadingItem = NSCollectionLayoutItem (
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        // Group
        let leadingItemGroup = NSCollectionLayoutGroup.vertical(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .fractionalHeight(1)),
            repeatingSubitem: leadingItem,
            count: 2
        )
        leadingItemGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [leadingItemGroup,trailingItem])
        // Headerview
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "HeaderView",
                                                                 alignment: .top)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
//         Uncomment this  line is you want to return UICollectionViewCompositionalLayout/
//        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Layout 11
    func layout11() -> NSCollectionLayoutSection {
        // Top Item 40 %
        let topItem1Size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .fractionalHeight(1.0)
        )
        let topItem1 = NSCollectionLayoutItem (
            layoutSize: topItem1Size
        )
        topItem1.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4)
        // Top item 60 %
        let topItem2Size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.6),
            heightDimension: .fractionalHeight(1.0)
        )
        let topItem2 = NSCollectionLayoutItem (
            layoutSize: topItem2Size
        )
        topItem2.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0)
        let topGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [topItem1,topItem2])
        topGroup.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 4, trailing: 8)
        // Bottom Item 60 %
        let bottomItem1Size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.6),
            heightDimension: .fractionalHeight(1.0)
        )
        let bottomItem1 = NSCollectionLayoutItem (
            layoutSize: bottomItem1Size
        )
        bottomItem1.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4)
        // Top item 60 %
        let bottomItem2Size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .fractionalHeight(1.0)
        )
        let bottomItem2 = NSCollectionLayoutItem (
            layoutSize: bottomItem2Size
        )
        bottomItem2.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0)
        let bottomGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [bottomItem1,bottomItem2])
        bottomGroup.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 8, trailing: 8)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [topGroup,bottomGroup])
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "HeaderView",
                                                                 alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
//         Uncomment this  line is you want to return UICollectionViewCompositionalLayout
//        return UICollectionViewCompositionalLayout(section: section)
        
    }

    // MARK: - Layout 12
    func layout12() -> NSCollectionLayoutSection {
        // Top Item 40 %
        let topItem1Size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .fractionalHeight(1.0)
        )
        let topItem1 = NSCollectionLayoutItem (
            layoutSize: topItem1Size
        )
        topItem1.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4)
        // Top item 60 %
        let topItem2Size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.6),
            heightDimension: .fractionalHeight(1.0)
        )
        let topItem2 = NSCollectionLayoutItem (
            layoutSize: topItem2Size
        )
        topItem2.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0)
        let topGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [topItem1,topItem2])
        topGroup.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 4, trailing: 8)
        // Bottom Item 60 %
        let bottomItem1Size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.6),
            heightDimension: .fractionalHeight(1.0)
        )
        let bottomItem1 = NSCollectionLayoutItem (
            layoutSize: bottomItem1Size
        )
        bottomItem1.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4)
        // Top item 60 %
        let bottomItem2Size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .fractionalHeight(1.0)
        )
        let bottomItem2 = NSCollectionLayoutItem (
            layoutSize: bottomItem2Size
        )
        bottomItem2.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0)
        let bottomGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [bottomItem1,bottomItem2])
        bottomGroup.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 8, trailing: 8)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [bottomGroup, topGroup])
        // Headerview
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "HeaderView",
                                                                 alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
//         Uncomment this  line is you want to return UICollectionViewCompositionalLayout
//        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    
}
