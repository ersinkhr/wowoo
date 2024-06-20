//
//  MainViewController.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import UIKit

final class MainViewController: BaseViewController {
    
    private var viewModel: MainViewModelProtocol
    private var isCollectionLayoutList: Bool = true
    
    private lazy var listCVLayout: UICollectionViewFlowLayout = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width - 32,
                                                          height: 72)
        collectionFlowLayout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.width,
                                                          height: 48)
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0,
                                                         left: 16,
                                                         bottom: 0,
                                                         right: 16)
        collectionFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width,
                                               height: 250)
        collectionFlowLayout.minimumInteritemSpacing = 0
        collectionFlowLayout.minimumLineSpacing = 12
        collectionFlowLayout.scrollDirection = .vertical
        return collectionFlowLayout
    }()
    
    private lazy var gridCVLayout: UICollectionViewFlowLayout = {
        
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width - 32,
                                                          height: 72)

        collectionFlowLayout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.width,
                                                          height: 48)
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionFlowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 40) / 2 ,
                                               height: 250)
        collectionFlowLayout.minimumInteritemSpacing = 8
        collectionFlowLayout.minimumLineSpacing = 8
        return collectionFlowLayout
    }()
    
    private lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Movies"
        searchBar.delegate = self
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: gridCVLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellWithClass: MainCollectionViewCell.self)
        collectionView.register(footerView: MainCollectionViewFooterView.self)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")
        return collectionView
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let image: UIImage = .changeIcon.withRenderingMode(.alwaysOriginal)
        let changeViewButton = UIBarButtonItem(
            image: image,
            landscapeImagePhone: image,
            style: .plain,
            target: self,
            action: #selector(switchCollectionView))
        changeViewButton.setBackgroundVerticalPositionAdjustment(-3, for: .default)
        return changeViewButton
    }()
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
}

private extension MainViewController {
    func prepareUI() {
        title = "Favorite Movies List"
        viewModel.fetchFavoriteMovies()
        navigationItem.rightBarButtonItem = rightBarButtonItem
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        registerViewModel()
    }
    
    func registerViewModel() {
        viewModel.viewDataDidFetch = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc
    func switchCollectionView() {
        self.collectionView.startInteractiveTransition(to: isCollectionLayoutList ? self.listCVLayout : self.gridCVLayout, completion: nil)
        self.collectionView.finishInteractiveTransition()
        collectionView.setContentOffset(CGPoint.zero, animated: true)
        isCollectionLayoutList.toggle()
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cell: MainCollectionViewCell.self)
        cell.configureWithModel(viewModel.itemForIndexPath(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.reusableFooterView(for: indexPath, MainCollectionViewFooterView.self)
            footer.userDidTaploadMore = { [weak self] in
                self?.viewModel.fetchFavoriteMovies()
            }
            return footer
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "headerCellId",
                                                                         for: indexPath)
            header.addSubview(searchBar)
            searchBar.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview().inset(16)
                make.horizontalEdges.equalToSuperview()
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension MainViewController: UISearchBarDelegate {
    
}
