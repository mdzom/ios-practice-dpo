//
//  TabBarController.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 15.10.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBar()
    }
    
    private func generateTabBar() {
        viewControllers = [
            ModelBuilder.createBasketModule(),
            ModelBuilder.createChartModule(),
            ModelBuilder.createMainModule()]
    }
    
    private func setTabBar() {
        let width = tabBar.bounds.width
        let height = 0.5
        
        let line = CAShapeLayer()
        let bezierPath = UIBezierPath(rect: CGRect(x: 0,
                                                   y: 0,
                                                   width: width,
                                                   height: height))
        line.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(line,
                                    at: 0)
    }
}
