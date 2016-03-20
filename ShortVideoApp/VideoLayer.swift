import AVFoundation

class VideoLayer {

    internal var parent: CALayer?

    internal var video: CALayer? {
        didSet {
            parent = video
        }
    }

    init() {
        parent = CALayer()
    }

}