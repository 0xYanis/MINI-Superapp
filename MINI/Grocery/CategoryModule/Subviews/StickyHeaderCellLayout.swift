//
//  StickyHeaderCellLayout.swift
//  MINI
//
//  Created by Yan Rybkin on 27.07.2023.
//

import UIKit

final class StickyHeaderCellLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        let headerNeedingLayout = NSMutableIndexSet()
        guard var layoutAttributes = layoutAttributes else { return nil }
        for attributes in layoutAttributes {
            if attributes.representedElementCategory == .cell {
                headerNeedingLayout.add(attributes.indexPath.section)
            }
        }
        
        for attributes in layoutAttributes {
            if let elementKind = attributes.representedElementKind {
                if elementKind == UICollectionView.elementKindSectionHeader {
                    headerNeedingLayout.remove(attributes.indexPath.section)
                }
            }
        }
        
        headerNeedingLayout.enumerate { (index, stop) in
            let indexPath = IndexPath(item: 0, section: index)
            let attributes = self.layoutAttributesForSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                at: indexPath
            )
            let defaultAttributes = UICollectionViewLayoutAttributes()
            layoutAttributes.append(attributes ?? defaultAttributes)
        }
        
        for attributes in layoutAttributes {
            if let elementKind = attributes.representedElementKind {
                if elementKind == UICollectionView.elementKindSectionHeader {
                    let section = attributes.indexPath.section
                    guard let attributesForFirstItemInSection = layoutAttributesForItem(
                        at: IndexPath(
                            item: 0,
                            section: section)
                    ) else { return [] }
                    guard let attributesForLastItemInSection = layoutAttributesForItem(
                        at: IndexPath(
                            item: collectionView?.numberOfItems(inSection: section - 1) ?? 0,
                            section: section)
                    ) else { return [] }
                    var frame = attributes.frame
                    guard let offset = collectionView?.contentOffset.y else { return [] }
                    let minY = CGRectGetMinX(attributesForFirstItemInSection.frame) - frame.height
                    let maxY = CGRectGetMaxY(attributesForLastItemInSection.frame) - frame.height
                    
                    let y = min(max(offset, minY), maxY)
                    frame.origin.y = y
                    attributes.zIndex = 99
                }
            }
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
