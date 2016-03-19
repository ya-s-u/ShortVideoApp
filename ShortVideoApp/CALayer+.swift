import QuartzCore

extension CALayer {

    class func startAPNGWithURL(url: NSURL, layer: CALayer) {
        let animation = CAKeyframeAnimation.APNGWithURL(url)
        layer.addAnimation(animation, forKey: "contents")
    }

}