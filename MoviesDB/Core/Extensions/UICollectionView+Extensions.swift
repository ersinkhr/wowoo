//
//  UICollectionView+Extensions.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        String(describing: self)
    }

    static var elementKind: String {
        reuseIdentifier
    }
}

extension UICollectionView {
    public final func register<T: UICollectionViewCell>(cellWithClass cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }

    public final func register<T: UICollectionViewCell>(cellWithNib cell: T.Type) {
        let nib = UINib(nibName: cell.reuseIdentifier, bundle: Bundle(for: cell.self))
        register(nib, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }

    public final func register<T: UICollectionReusableView>(headerView: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerView.reuseIdentifier)
    }

    public final func register<T: UICollectionReusableView>(footerView: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: footerView.reuseIdentifier)
    }

    public final func register<T: UICollectionReusableView>(view: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: view.reuseIdentifier,
            withReuseIdentifier: view.reuseIdentifier)
    }

    public final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cell: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath) as? T else {
            fatalError("\(String(describing: cell)) cell should register")
        }
        return cell
    }

    public func reusableView<T: UICollectionReusableView>(for indexPath: IndexPath, _ view: T.Type = T.self) -> T {
        guard let supplementaryView = dequeueReusableSupplementaryView(
            ofKind: view.reuseIdentifier,
            withReuseIdentifier: view.reuseIdentifier,
            for: indexPath) as? T else {
            fatalError("\(view.reuseIdentifier) header view should register")
        }
        return supplementaryView
    }

    public func reusableHeaderView<T: UICollectionReusableView>(for indexPath: IndexPath, _ view: T.Type = T.self) -> T {
        guard let headerView = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: view.reuseIdentifier,
            for: indexPath) as? T else {
            fatalError("\(view.reuseIdentifier) header view should register")
        }
        return headerView
    }

    public func reusableFooterView<T: UICollectionReusableView>(for indexPath: IndexPath, _ view: T.Type = T.self) -> T {
        guard let footerView = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: String(describing: view),
            for: indexPath) as? T else {
            fatalError("\(String(describing: view)) footer view should register")
        }
        return footerView
    }
}
