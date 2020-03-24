//
//  CircularProgressBar.swift
//  VoiceClub
//
//  Created by Bibin Jaimon on 23/03/20.
//  Copyright © 2020 Bibin Jaimon. All rights reserved.
//


import Foundation
import UIKit

protocol CircularProgressViewDataSource {
    func progressView(trackColorFor tag: Int) -> UIColor
    func progressView(progressFillColorFor tag: Int) -> UIColor
    func progressView(trackWidthFor tag: Int) -> CGFloat
    func progressView(trackRadiusFor tag: Int) -> CGFloat
    func progressView(startAngleFor tag: Int) -> CGFloat
    func progressView(endAngleFor tag: Int) -> CGFloat
    func progressView(isClockWise tag: Int) -> Bool
}

protocol CircularProgressViewDelegate {
    func progressView(didFinishedFor tag: Int)
}

extension CircularProgressViewDataSource {
    func progressView(startAngleFor tag: Int) -> CGFloat {
        return -CGFloat.pi / 2
    }
    func progressView(endAngleFor tag: Int) -> CGFloat {
        return 2 * CGFloat.pi
    }
    func progressView(isClockWise tag: Int) -> Bool {
        return true
    }
}

class CircularProgressView: CAShapeLayer {
    
    private var circularShapeLayer: CAShapeLayer!
    private var basicAnimation: CABasicAnimation!
    private let keyPath = "strokeEnd"
    
    var layerBounds: CGRect
    var tag: Int = 0
    
    var dataSource: CircularProgressViewDataSource? {
        didSet {
            setupCircularLayer()
//            setupCircularProgressAnimation()
        }
    }
    var progressViewDelegate: CircularProgressViewDelegate?
    
    init(layerBounds: CGRect) {
        self.layerBounds = layerBounds
        super.init()
    }
    
    private func setupCircularProgressAnimation() {
        basicAnimation = CABasicAnimation(keyPath: self.keyPath)
        basicAnimation.fromValue = 0
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
//        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        circularShapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    private func setupCircularLayer() {
        
        let tackColor = dataSource?.progressView(trackColorFor: self.tag) ?? UIColor.clear
        let trackWidth = dataSource?.progressView(trackWidthFor: self.tag) ?? 2
        let trackRadius = dataSource?.progressView(trackRadiusFor: self.tag) ?? 100
        
        let progressColor = dataSource?.progressView(progressFillColorFor: self.tag) ?? UIColor.black
        let startAngle = dataSource?.progressView(startAngleFor: self.tag)
        let endAngle = dataSource?.progressView(endAngleFor: self.tag)
        
        let center = CGPoint(x: self.layerBounds.midX, y: self.layerBounds.midY)
        let clockwise = dataSource?.progressView(isClockWise: self.tag)
        
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: trackRadius,
                                        startAngle: startAngle!,
                                        endAngle: endAngle!,
                                        clockwise: clockwise!)
        
        let trackLayer = getTrackLayer(trackColor: tackColor,
                                       lineWidth: trackWidth,
                                       strokeEnd: 1,
                                       path: circularPath)
        
        self.addSublayer(trackLayer)
        
        self.circularShapeLayer = getTrackLayer(trackColor: progressColor,
                                                lineWidth: trackWidth,
                                                strokeEnd: 0.0,
                                                path: circularPath)
        
        self.addSublayer(circularShapeLayer)
    }
    
    
    private func getTrackLayer(trackColor: UIColor,
                               lineWidth: CGFloat,
                               strokeEnd: CGFloat,
                               lineCap: CAShapeLayerLineCap = CAShapeLayerLineCap.round,
                               fillColor: UIColor = UIColor.clear,
                               path: UIBezierPath) -> CAShapeLayer {
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = path.cgPath
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.fillColor = fillColor.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.strokeEnd = strokeEnd
        trackLayer.lineCap = CAShapeLayerLineCap.round
        return trackLayer
    }
    
    func setProgress(to: CGFloat) {
        if dataSource == nil { return }
//        basicAnimation.toValue = to
        DispatchQueue.main.async { [weak self] in
            self?.circularShapeLayer.strokeEnd = to
        }
    }
    
    func reset() {
        self.circularShapeLayer.strokeEnd = 0.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("Deinitialized Layer")
    }
}

