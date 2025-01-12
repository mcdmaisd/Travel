//
//  UICollectionView+Extension.swift
//  UpDown
//
//  Created by ilim on 2025-01-10.
//

import UIKit

extension UICollectionView {
    func configureFlowLayout(numberOfItemsInRow: CGFloat, numberofItemsInColumn: CGFloat, inset: CGFloat = 10) {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - (numberOfItemsInRow + 1) * inset) / numberOfItemsInRow
        let itemHeight = (screenWidth - (numberofItemsInColumn + 1) * inset) / numberofItemsInColumn
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = inset
        layout.minimumInteritemSpacing = inset
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)

        self.collectionViewLayout = layout
    }
}
