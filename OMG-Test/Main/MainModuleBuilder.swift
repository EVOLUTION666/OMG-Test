//
//  MainModuleBuilder.swift
//  Nefedov Andrey
//
//  Created by Andrey on 11.03.2024
//

import UIKit

class MainModuleBuilder {
    static func build() -> MainViewController {
        let interactor = MainInteractor()
        let router = MainRouter()
        let presenter = MainPresenter(interactor: interactor, router: router)
        let viewController = MainViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
