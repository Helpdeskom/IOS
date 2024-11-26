//
//  PhotoLayoutVM.swift
//  GalleryTemplate_POC
//
//  Created by orange on 12/03/24.
//

import Foundation
import UIKit

class PhotoLayoutVM {
    // MARK: - Properties
    var sectionButtonTapped : Int = 0
    var sectionLayouts: [SectionLayoutModel] = [
        SectionLayoutModel(numberOfImage: 1, sectionIndex: 0, layoutType: LayoutType.layout1.compositionalLayout()),
        SectionLayoutModel(numberOfImage: 2, sectionIndex: 1, layoutType: LayoutType.layout2.compositionalLayout()),
        SectionLayoutModel(numberOfImage: 4, sectionIndex: 2, layoutType: LayoutType.layout3.compositionalLayout()),
        SectionLayoutModel(numberOfImage: 2, sectionIndex: 3, layoutType: LayoutType.layout4.compositionalLayout()),
        SectionLayoutModel(numberOfImage: 3, sectionIndex: 4, layoutType: LayoutType.layout5.compositionalLayout()),
        SectionLayoutModel(numberOfImage: 3, sectionIndex: 5, layoutType: LayoutType.layout6.compositionalLayout()),
        SectionLayoutModel(numberOfImage: 3, sectionIndex: 6, layoutType: LayoutType.layout7.compositionalLayout()),
        SectionLayoutModel(numberOfImage: 3, sectionIndex: 7, layoutType: LayoutType.layout8.compositionalLayout()),
        SectionLayoutModel(numberOfImage: 3, sectionIndex: 8, layoutType: LayoutType.layout9.compositionalLayout()),
        SectionLayoutModel(numberOfImage: 3, sectionIndex: 9, layoutType: LayoutType.layout10.compositionalLayout()),
        SectionLayoutModel(numberOfImage: 4, sectionIndex: 10, layoutType: LayoutType.layout11.compositionalLayout()),
        SectionLayoutModel(numberOfImage: 4, sectionIndex: 11, layoutType: LayoutType.layout12.compositionalLayout()),
    ]
    var initialLayoutArray : [SectionLayoutModel] = []
    var croppedImageArray = [UIImage]()
    var section : Int = 0
    static let headerView = "HeaderView"
    var isInitial : Bool = true
    var albumName : String = ""
    // MARK: - Functions for creating PDF of Content of UIcolllectionView
    func PDFWithScrollView(scrollview: UIScrollView) -> NSData {
        let pageDimensions = scrollview.bounds
        let pageSize = pageDimensions.size
        let totalSize = scrollview.contentSize
        let numberOfPagesThatFitHorizontally = Int(ceil(totalSize.width / pageSize.width))
        let numberOfPagesThatFitVertically = Int(ceil(totalSize.height / pageSize.height))
        let outputData = NSMutableData()
        UIGraphicsBeginPDFContextToData(outputData, pageDimensions, nil)
        let savedContentOffset = scrollview.contentOffset
        let savedContentInset = scrollview.contentInset
        scrollview.contentInset = UIEdgeInsets.zero
        if let context = UIGraphicsGetCurrentContext()
        {
            for indexHorizontal in 0 ..< numberOfPagesThatFitHorizontally
            {
                for indexVertical in 0 ..< numberOfPagesThatFitVertically
                {
                    UIGraphicsBeginPDFPage()
                    let offsetHorizontal = CGFloat(indexHorizontal) * pageSize.width
                    let offsetVertical = CGFloat(indexVertical) * pageSize.height
                    scrollview.contentOffset = CGPointMake(offsetHorizontal, offsetVertical)
                    context.translateBy(x: -offsetHorizontal, y: -offsetVertical)
                    scrollview.layer.render(in: context)
                }
            }
        }
        UIGraphicsEndPDFContext()
        scrollview.contentInset = savedContentInset
        scrollview.contentOffset = savedContentOffset
        return outputData
    }
    // Function for saving the file
    func savePDFDataAsFile(pdfData: NSData, fileName: String) {
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let downloadsURL = documentsDirectory.appendingPathComponent("Downloads")
            try? FileManager.default.createDirectory(at: downloadsURL, withIntermediateDirectories: true, attributes: nil)
            
            let fileURL = downloadsURL.appendingPathComponent(fileName)
            pdfData.write(to: fileURL, atomically: true)
            print("PDF file saved to: \(fileURL)")
        }
    }    
}
