//
//  MainCollectionViewCell.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithModel(_ model: MainMoviewCellRepresentationModel) {
        posterImageView.load(from: model.imageUrl)
        titleLabel.text = model.title
    }
}

private extension MainCollectionViewCell {
    func prepareUI() {
        addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let alpheView = UIView()
        alpheView.backgroundColor = .black.withAlphaComponent(0.66)
        addSubview(alpheView)
        alpheView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        alpheView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(12)
        }
    }
}
