//
//  MainViewController.swift
//  Nefedov Andrey
//
//  Created by Andrey on 11.03.2024
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func reloadItems(paths: [IndexPath])
}

class MainViewController: UIViewController {
    // MARK: - Public
    var presenter: MainPresenterProtocol?
    
    // MARK: - Private
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: compositionalLayout()).forAutoLayout()
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(BorderSquareCollectionCell.self, forCellWithReuseIdentifier: BorderSquareCollectionCell.identidier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItemsInSection(section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BorderSquareCollectionCell.identidier,
            for: indexPath) as? BorderSquareCollectionCell else { fatalError("Can't create cell") }
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        presenter?.configure(cell: cell, for: indexPath)
        return cell
    }
}

// MARK: - Private functions
private extension MainViewController {
    func initialize() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.setSimpleConstraints()
    }
    
    func compositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {

    func reloadItems(paths: [IndexPath]) {
        self.collectionView.reloadItems(at: paths)
    }
}
