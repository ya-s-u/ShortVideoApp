import AVFoundation
import ImageIO

extension CAKeyframeAnimation {

    class func APNGWithURL(url: NSURL) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "contents")

        var frames = [CGImage]()
        var delayTimes = [Double]()

        let gifSource = CGImageSourceCreateWithURL(url, nil)

        let frameCount = CGImageSourceGetCount(gifSource!)
        for i in 0...frameCount-1 {
            let frame = CGImageSourceCreateImageAtIndex(gifSource!, i, nil)
            frames.append(frame!)

            let delayTime = delayForImageAtIndex(i, source: gifSource)
            delayTimes.append(delayTime)
        }

        let totalTime = delayTimes.reduce(0, combine: +)

        var times = [Double]()
        var currentTime = 0.0
        let count = delayTimes.count

        for i in 0...count-1 {
            times.append(currentTime/totalTime)
            currentTime += delayTimes[i]
        }

        animation.keyTimes = times
        animation.values = frames
        animation.duration = totalTime
        animation.repeatCount = Float.infinity
        animation.beginTime = AVCoreAnimationBeginTimeAtZero
        animation.removedOnCompletion = false
        
        return animation
    }

    class func delayForImageAtIndex(index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1

        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties:CFDictionaryRef = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                unsafeAddressOf(kCGImagePropertyGIFDictionary)),
            CFDictionary.self)

        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                unsafeAddressOf(kCGImagePropertyGIFUnclampedDelayTime)),
            AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                unsafeAddressOf(kCGImagePropertyGIFDelayTime)), AnyObject.self)
        }

        delay = delayObject as! Double

        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }

}