//
//  MainPresenter.swift
//  Nefedov Andrey
//
//  Created by Andrey on 11.03.2024
//

import UIKit

protocol MainPresenterProtocol: AnyObject {
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func configure(cell: UICollectionViewCell, for indexPath: IndexPath)
    func didUpdateRandomValue(indexPaths: [IndexPath])
}

class MainPresenter {
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol
    var interactor: MainInteractorProtocol
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MainPresenter: MainPresenterProtocol {
    func didUpdateRandomValue(indexPaths: [IndexPath]) {
        view?.reloadItems(paths: indexPaths)
    }
    
    func numberOfSections() -> Int {
        return interactor.numberOfSections()
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return interactor.numberOfItemsInSection(section)
    }
    
    func configure(cell: UICollectionViewCell, for indexPath: IndexPath) {
        guard let cell = cell as? BorderSquareCollectionCell else { fatalError("Can't create cell") }
        let value = interactor.valueForRow(indexPath.row, inSection: indexPath.section)
        cell.configureCell(number: value)
    }
}
