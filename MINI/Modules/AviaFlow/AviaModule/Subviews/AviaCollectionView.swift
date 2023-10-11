//
//  AviaCollectionView.swift
//  MINI
//
//  Created by Yan Rybkin on 11.09.2023.
//

import UIKit
import SnapKit

protocol AviaCellProtocol: UICollectionViewCell {
    func configure(with data: AviaItem)
}

final class AviaCollectionView: UICollectionView {
    
    public var presenter: AviaPresenterProtocol?
    public weak var aviaDelegate: AviaSearchViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func initialize() {
        backgroundColor = UIColor.midnightBlue.lighter.lighter
        contentInsetAdjustmentBehavior = .never
        dataSource = self
        delegate = self
        
        register(AviaDealCell.self)
        register(AviaPlaceCell.self)
        register(AviaCityCell.self)
        register(AviaCountryCell.self)
        register(AviaSearchView.self)
        
        collectionViewLayout = createLayout()
    }
    
}

//MARK: - Private methods

private extension AviaCollectionView {
    
    func register<C: UICollectionViewCell>(_ cell: C.Type) {
        register(cell, forCellWithReuseIdentifier: String(describing: cell))
    }
    
    func register<S: UICollectionReusableView>(_ view: S.Type, isHeader: Bool = true) {
        let head = UICollectionView.elementKindSectionHeader
        let foot = UICollectionView.elementKindSectionFooter
        register(
            view,
            forSupplementaryViewOfKind: isHeader ? head : foot,
            withReuseIdentifier: String(describing: view)
        )
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
    
    func makeSearchItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(400)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
    }
    
    var hotDealsSection: NSCollectionLayoutSection {
        let searchItem = makeSearchItem()
        searchItem.zIndex = 0
        
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(0.25)), subitems: [item])
        group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        let section = createSection(group: group, behavior: .groupPaging, interGroupSpacing: 0,supplementaryItems: [searchItem], haveInsets: false)
        section.contentInsets = .init(top: -30, leading: 0, bottom: 0, trailing: 0)
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
        section.contentInsets = .init(top: 50, leading: 16, bottom: 0, trailing: 16)
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
        section.contentInsets = .init(top: 50, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    var countriesSection: NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(0.25)), subitems: [item])
        let section = createSection(group: group, behavior: .continuousGroupLeadingBoundary, interGroupSpacing: 15, haveInsets: true)
        section.contentInsets = .init(top: 50, leading: 16, bottom: 50, trailing: 16)
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: String(describing: AviaSearchView.self),
                    for: indexPath) as? AviaSearchView
            else { return UICollectionReusableView() }
            header.delegate = aviaDelegate
            return header
        case UICollectionView.elementKindSectionFooter:
            return UICollectionReusableView()
        default:
            return UICollectionReusableView()
        }
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
/*
 
import SwiftUI

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
 
*/
