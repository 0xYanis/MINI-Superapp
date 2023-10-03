//
//  AviaCollectionView.swift
//  MINI
//
//  Created by Yan Rybkin on 11.09.2023.
//

import UIKit
import SnapKit
import SwiftUI

protocol AviaCellProtocol: UICollectionViewCell {
    func configure(with data: AviaItem)
}

final class AviaCollectionView: UICollectionView {
    
    public var presenter: AviaPresenterProtocol?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

private extension AviaCollectionView {
    
    func initialize() {
        backgroundColor = .none
        dataSource = self
        delegate = self
        
        register(AviaDealCell.self)
        register(AviaPlaceCell.self)
        register(AviaCityCell.self)
        register(AviaCountryCell.self)
        
        collectionViewLayout = createLayout()
    }
    
    func register<C: UICollectionViewCell>(_ cell: C.Type) {
        register(cell, forCellWithReuseIdentifier: String(describing: cell))
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.presenter?.getDataSource()[sectionIndex]
            switch section {
            case .hotDeals(_):  return self.hotDealsSection
            case .places(_):    return self.placesSection
            case .cities(_):    return self.citiesSection
            case .countries(_): return self.countriesSection
            case .none: return nil
            }
        }
    }
    
    var hotDealsSection: NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(0.95),
            heightDimension: .fractionalHeight(0.25)), subitems: [item])
        let section = createSection(group: group, behavior: .groupPagingCentered, interGroupSpacing: 5, haveInsets: false)
        return section
    }
    
    var placesSection: NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(0.35),
            heightDimension: .fractionalHeight(0.15)), subitems: [item])
        let section = createSection(group: group, behavior: .continuous, interGroupSpacing: 10, haveInsets: true)
        section.contentInsets = .init(top: 20, leading: 16, bottom: 20, trailing: 16)
        return section
    }
    
    var citiesSection: NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(0.7),
            heightDimension: .fractionalHeight(0.3)), subitems: [item])
        let section = createSection(group: group, behavior: .groupPaging, interGroupSpacing: 10, haveInsets: true)
        
        return section
    }
    
    var countriesSection: NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(0.12)), subitems: [item])
        let section = createSection(group: group, behavior: .continuousGroupLeadingBoundary, interGroupSpacing: 15, haveInsets: true)
        section.contentInsets = .init(top: 20, leading: 16, bottom: 20, trailing: 16)
        return section
    }
 
    func createSection(
        group: NSCollectionLayoutGroup,
        behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
        interGroupSpacing: CGFloat,
        supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = [],
        haveInsets: Bool
    ) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        
        let inset: NSDirectionalEdgeInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.contentInsets = haveInsets ? inset : .zero
        
        return section
    }
    
}

// MARK: - UICollectionViewDataSource

extension AviaCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        presenter?.getDataSource().count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        presenter?.getDataSource()[section].count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let data = presenter?.getDataSource() ?? []
        switch data[indexPath.section] {
        case .hotDeals(let hotdeals):
            return dequeue(AviaDealCell.self, collectionView, indexPath, data: hotdeals[indexPath.row])
        case .places(let places):
            return dequeue(AviaPlaceCell.self, collectionView, indexPath, data: places[indexPath.row])
        case .cities(let cities):
            return dequeue(AviaCityCell.self, collectionView, indexPath, data: cities[indexPath.row])
        case .countries(let counties):
            return dequeue(AviaCountryCell.self, collectionView, indexPath, data: counties[indexPath.row])
        }
    }
    
    private func dequeue<C: AviaCellProtocol>(
        _ cell: C.Type,
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        data: AviaItem
    ) -> C {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: cell),
            for: indexPath) as? C
        else { fatalError("Error from cell: \(cell)") }
        cell.configure(with: data)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension AviaCollectionView: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        
    }
    
}

struct AviaPreview: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            ContentView().ignoresSafeArea()
                .navigationTitle("Avia")
                .navigationBarTitleDisplayMode(.large)
        }
    }
    
    struct ContentView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return AviaBuilder.build()
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
    }
}
