//
//  MyLayout.swift
//  CustomiseGridView
//
//  Created by Appinventiv Mac on 07/03/18.
//  Copyright © 2018 Appinventiv Mac. All rights reserved.
//

import UIKit
protocol MyLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}

class CustomLayout: UICollectionViewLayout {
    
    var index:Int?
    
    var delegate: MyLayoutDelegate!
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 50.0, right: 5.0)
    fileprivate var numberOfColumns = 3
    fileprivate var cellPadding: CGFloat = 3
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.bounds.width - (sectionInsets.left + sectionInsets.right)
    }
    
    //MARK: --> Content size of collection view
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    //MARK: Preparing
    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        let columnWidth = getWidth()
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoHeight = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
            let height = cellPadding * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }

    //MARK: Method 3
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

//    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//
//        let headerView = collectionView?.dequeueReusableSupplementaryView(ofKind: elementKind,withReuseIdentifier: "HeaderCollectionReusableView",for: indexPath) as! HeaderCollectionReusableView
//            return headerView
//
//        }

    func getWidth()-> CGFloat{
        let availableWidth = collectionView?.bounds.width
        var columnWidth : CGFloat = 0.0
        if index == 0{
            let cw = ((availableWidth! / CGFloat(2))) + 5
            columnWidth = cw
            return columnWidth
        }
        else{
            let cw = availableWidth! / CGFloat(numberOfColumns)
            columnWidth = cw
            return columnWidth
        }
    }
}




