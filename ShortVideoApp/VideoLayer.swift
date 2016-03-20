import AVFoundation

class VideoLayer {

    internal var parent: CALayer?

    internal var video: CALayer? {
        didSet {
            parent = video
        }
    }

    internal var frames: [VideoAnimation]?

    init() {
        parent = CALayer()
        frames = []
    }

    internal func drawFrames() {
        guard let frames = frames else {
            return
        }
        for frame in frames {
            guard let layer = frame.layer else {
                return
            }
            parent?.addSublayer(layer)
        }
    }

}