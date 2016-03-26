import Foundation
import AVFoundation

extension CALayer {

    class func anime(images: [CGImage], durations: [Double]) -> CALayer {
        let total = durations.reduce(0, combine: +)

        var times = [Double]()
        var currentTime = 0.0
        let count = durations.count

        for i in 0...count-1 {
            times.append(currentTime/total)
            currentTime += durations[i]
        }

        let layer = CALayer()
        let animation = CAKeyframeAnimation(keyPath: "contents")
        animation.keyTimes = times
        animation.values = images
        animation.duration = total
        animation.repeatCount = Float.infinity
        animation.beginTime = AVCoreAnimationBeginTimeAtZero
        animation.removedOnCompletion = false
        layer.addAnimation(animation, forKey: "contents")

        return layer
    }

}