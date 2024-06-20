//
//  MainCollectionViewFooterView.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import UIKit

final class MainCollectionViewFooterView: UICollectionReusableView {
    var userDidTaploadMore : (() -> Void)?
    private lazy var loadMoreButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitle("Load More", for: .normal)
        button.addTarget(self, action: #selector(loadMoreTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainCollectionViewFooterView {
    func prepareUI() {
        addSubview(loadMoreButton)
        loadMoreButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    @objc
    func loadMoreTapped() {
        userDidTaploadMore?()
    }
}
