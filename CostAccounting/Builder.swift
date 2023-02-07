//
//  Builder.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 15.10.2022.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createBasketModule() -> UIViewController
    static func createChartModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let navigation = UINavigationController(rootViewController: view)
        navigation.tabBarItem = UITabBarItem(title: "Расходы",
                                             image: UIImage(systemName: "circle"),
                                             tag: 0)
        view.view.backgroundColor = .systemBackground
        return navigation
    }
    
    static func createBasketModule() -> UIViewController {
        let view = BasketViewController()
        let navigation = UINavigationController(rootViewController: view)
        navigation.tabBarItem = UITabBarItem(title: "Доходы",
                                             image: UIImage(systemName: "circle"),
                                             tag: 1)
        view.view.backgroundColor = .systemBackground
        
        return navigation
    }
    
    static func createChartModule() -> UIViewController {
        let view = ExpenseScheduleViewController()
        let navigation = UINavigationController(rootViewController: view)
        navigation.tabBarItem = UITabBarItem(title: "График",
                                             image: UIImage(systemName: "circle"),
                                             tag: 2)
        view.view.backgroundColor = .systemBackground
        
        return navigation
    }
}
