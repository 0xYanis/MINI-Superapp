//
//  AviaViewLayoutBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 31.07.2023.
//

import UIKit

final class AviaViewLayout {
    
    static func build() {
        
    }
    
}

// MARK: - Items

private extension AviaViewLayout {
    
    func defaultItem(width: Double) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(width),
            heightDimension: .fractionalHeight(1))
        return NSCollectionLayoutItem(layoutSize: itemSize)
    }
    
}

// MARK: - Sections

private extension AviaViewLayout {
    
    func searchSection() -> NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(220))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [self.defaultItem(width: 1)])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    
    func lastSeenSection() -> NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [self.defaultItem(width: 1)])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func interestingSection() -> NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(120))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [self.defaultItem(width: 0.25)])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
}
