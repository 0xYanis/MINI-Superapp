//
//  BankCollectionView.swift
//  MINI
//
//  Created by Yanis on 02.10.2023.
//

import UIKit

final class BankCollectionView: UICollectionView {
    
    public weak var presenter: BankPresenterProtocol?
    
    private var dataIsHidden: Bool = false
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func hidePersonalData() {
        dataIsHidden.toggle()
        reloadSections(IndexSet(integer: 0))
    }
    
    private func initialize() {
        backgroundColor = .none
        dataSource = self
        delegate = self
        
        register(BankCardCell.self)
        register(BankEmptyCardCell.self)
        register(BankTemplateLabelCell.self, isHeader: true)
        register(BankTemplateCell.self)
        
        collectionViewLayout = makeLayout()
    }
    
}

//MARK: - Private layout methods

private extension BankCollectionView {
    
    func makeLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, env in
            guard let self = self else { return nil }
            let section = self.presenter?.getDataSource()[sectionIndex]
            switch section {
            case .card(_)    : return self.makeCardSection()
            case .template(_): return self.makeTemplateSection()
            case .none: return nil
            }
        }
    }
    
    func makeCardSection() -> NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.38),
            heightDimension: .fractionalHeight(0.15))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [defaultItem])
        let section = customSection(group: group, spacing: 15, scrollType: .groupPaging)
        section.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        return section
    }
    
    func makeTemplateSection() -> NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.35),
            heightDimension: .fractionalHeight(0.12))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [defaultItem])
        let section = customSection(group: group, subItems: [makeTemplateHeader()], spacing: 10, scrollType: .continuous)
        section.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        return section
    }
    
    func makeTemplateHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let kind = UICollectionView.elementKindSectionHeader
        return defaultSupplementaryItem(kind: kind, height: 30)
    }
    
}

//MARK: - Private helper methods

private extension BankCollectionView {
    
    var defaultItem: NSCollectionLayoutItem {
        return NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
    }
    
    func defaultSupplementaryItem(
        kind: String,
        height: CGFloat
    ) -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(height))
        return .init(
            layoutSize: size,
            elementKind: kind,
            alignment: .top
        )
    }
    
    func customSection(
        group: NSCollectionLayoutGroup,
        subItems: [NSCollectionLayoutBoundarySupplementaryItem] = [],
        spacing: CGFloat,
        scrollType: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous
    ) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = subItems
        section.interGroupSpacing = spacing
        section.orthogonalScrollingBehavior = scrollType
        return section
    }
    
    private func register<C: UICollectionViewCell>(_ cell: C.Type) {
        register(cell, forCellWithReuseIdentifier: String(describing: cell))
    }
    
    private func register<V: UICollectionReusableView>(
        _ view: V.Type,
        isHeader: Bool = true
    ) {
        let head = UICollectionView.elementKindSectionHeader
        let foot = UICollectionView.elementKindSectionFooter
        register(
            view,
            forSupplementaryViewOfKind: isHeader ? head : foot,
            withReuseIdentifier: String(describing: view)
        )
    }
    
}

//MARK: - UICollectionViewDataSource

extension BankCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        return presenter?.getDataSource().count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let sectionData = presenter?.getDataSource()[section]
        switch sectionData {
        case .card(let cards)        : return cards.count
        case .template(let templates): return templates.count
        case .none: return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let dataSource = presenter?.getDataSource()[indexPath.section]
        switch dataSource {
        case .card(let cards):
            if indexPath.item == (cards.count - 1) {
                let empty = dequeue(BankEmptyCardCell.self, collectionView, indexPath)
                return empty
            } else {
                let cell = dequeue(BankCardCell.self, collectionView, indexPath)
                cell.configure(with: cards[indexPath.item])
                cell.valueIsHidden = self.dataIsHidden
                return cell
            }
        case .template(let templates):
            let cell = dequeue(BankTemplateCell.self, collectionView, indexPath)
            cell.configure(with: templates[indexPath.item])
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    private func dequeue<C: UICollectionViewCell>(
        _ cell: C.Type,
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath
    ) -> C {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: cell),
            for: indexPath) as? C
        else { fatalError("Error from cell: \(cell)") }
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return dequeue(BankTemplateLabelCell.self, kind, collectionView, indexPath)
        case UICollectionView.elementKindSectionFooter:
            return UICollectionReusableView()
        default: return UICollectionReusableView()
        }
    }
    
    private func dequeue<V: UICollectionReusableView>(
        _ rview: V.Type,
        _ kind: String,
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath
    ) -> V {
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: rview),
            for: indexPath) as? V
        else { fatalError("Error from cell: \(rview)") }
        return view
    }
    
}

// MARK: - UICollectionViewDelegate

extension BankCollectionView: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        //presenter?.userWantToDetails(of: ., with: indexPath.item)
    }
    
}
import SwiftUI
struct SomePreview: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            ContentView()
                .navigationTitle("Bank")
        }
    }
    
    struct ContentView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return BankBuilder.build()
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
    }
}
