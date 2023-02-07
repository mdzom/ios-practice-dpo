//
//  ExpenseChartView.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 24.10.2022.
//

import UIKit

class ExpenseChartView: UIView {
    
    var viewModel: ExpenseChartViewModelProtocol? {
        willSet(viewModel) {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let viewModel else { return }
        
        if viewModel.dataAvailabilityCheck() {
            viewModel.setRect(rect)
            
            viewModel.getHorisontalLine { [weak self] value in
                self?.drawHorisontalLine(in: value)
            }
            
            viewModel.getVerticalLine { [weak self] value in
                self?.drawVerticalLine(in: value)
            }
            
            drawExpensesLine(coordinates: viewModel.getCoordinatesExpenses())
            drawIncomeLine(coordinates: viewModel.getCoordinatesIncome())
            
            viewModel.getCircleExpenses { [weak self] value in
                self?.drawCircle(in: value)
            }
            
            viewModel.getCircleIncome { [weak self] value in
                self?.drawCircle(in: value)
            }
        }
    }
    
    private func drawHorisontalLine(in rect: CGRect) {
        let path = UIBezierPath()
        
        let startPoint = CGPoint(x: 0,
                                 y: rect.origin.y)
        let endPoint = CGPoint(x: rect.width,
                               y: rect.origin.y)
        
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        path.close()
        
        path.lineWidth = 2
        
        let color = UIColor(red: 0.882,
                            green: 0.871,
                            blue: 0.871,
                            alpha: 1)
        color.setStroke()
        path.stroke()
        
    }
    
    private func drawVerticalLine(in rect: CGRect) {
        let path = UIBezierPath()
        
        let startPoint = CGPoint(x: rect.origin.x,
                                 y: 0)
        let endPoint = CGPoint(x: rect.origin.x,
                               y: rect.height)
        
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        path.lineWidth = 2
        
        let color = UIColor(red: 0.882,
                            green: 0.871,
                            blue: 0.871,
                            alpha: 1)
        color.setFill()
        path.stroke()
        
    }
    
    private func drawCircle(in rect: CGRect) {
        let center = CGPoint(x: rect.origin.x,
                             y: rect.origin.y)
        let radius: CGFloat = 4
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: 0,
                                endAngle: CGFloat.pi * 2,
                                clockwise: false)
        path.lineCapStyle = .round
        
        let color = UIColor(red: 0.847,
                            green: 0.847,
                            blue: 0.847,
                            alpha: 1)
        color.setFill()
        path.fill()
        
        let framePath = UIBezierPath(arcCenter: center,
                                     radius: radius,
                                     startAngle: 0,
                                     endAngle: CGFloat.pi * 2,
                                     clockwise: false)
        framePath.lineWidth = 1
        framePath.lineCapStyle = .round
        
        let frameColor = UIColor(red: 0.592,
                                 green: 0.592,
                                 blue: 0.592,
                                 alpha: 1)
        frameColor.setStroke()
        framePath.stroke()
    }

    private func drawExpensesLine(coordinates: [CGPoint]) {
        let path = UIBezierPath()
        guard let start = coordinates.first else {
            return
        }
        path.move(to: start)
        coordinates.forEach { path.addLine(to: $0) }
        path.lineWidth = 1
        
        let color = UIColor(red: 0.915,
                            green: 0.073,
                            blue: 0.073,
                            alpha: 1)
        color.setStroke()
        path.stroke()
    }

    private func drawIncomeLine(coordinates: [CGPoint]) {
        let path = UIBezierPath()
        guard let start = coordinates.first else {
            return
        }
        path.move(to: start)
        coordinates.forEach { path.addLine(to: $0) }
        path.lineWidth = 1
        
        let color = UIColor(red: 0.055,
                            green: 0.624,
                            blue: 0.004,
                            alpha: 1)
        color.setStroke()
        path.stroke()
    }
}
