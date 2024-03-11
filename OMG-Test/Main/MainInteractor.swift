//
//  MainInteractor.swift
//  Nefedov Andrey
//
//  Created by Andrey on 11.03.2024
//

import UIKit

protocol MainInteractorProtocol: AnyObject {
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func valueForRow(_ row: Int, inSection section: Int) -> Int
    func updateRandomValue(visibleItems: [[Int]])
}

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol?
    private var randomData: [[Int]] = []
    init() {
        generateRandomData()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateRandomValue(visibleItems: [])
        }
    }
}

extension MainInteractor {
    func numberOfSections() -> Int {
        return randomData.count
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return randomData[section].count
    }
    
    func valueForRow(_ row: Int, inSection section: Int) -> Int {
        return randomData[section][row]
    }
    
    func updateRandomValue(visibleItems: [[Int]]) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            guard !self.randomData.isEmpty else { return }
            var indexPathsToReload: [IndexPath] = []

            for section in 0..<self.randomData.count {
                let horizontalData = self.randomData[section]
                guard let randomItemInRow = Array(0..<horizontalData.count).randomElement() else { return }
                self.randomData[section][randomItemInRow] = Int.random(in: 1...100)
                let indexPath = IndexPath(item: randomItemInRow, section: section)

                indexPathsToReload.append(indexPath)
            }
            
            DispatchQueue.main.async {
                self.presenter?.didUpdateRandomValue(indexPaths: indexPathsToReload)
            }
        }
    }
}

private extension MainInteractor {
    func generateRandomData() {
        for _ in 0..<Int.random(in: 101...200) {
            var sectionData: [Int] = []
            for _ in 0..<Int.random(in: 11...30) {
                sectionData.append(Int.random(in: 1...100))
            }
            randomData.append(sectionData)
        }
    }
}
