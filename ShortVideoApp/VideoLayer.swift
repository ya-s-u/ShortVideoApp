import AVFoundation

class VideoLayer {

    internal var parent: CALayer?

    internal var video: CALayer? {
        didSet {
            parent = video
        }
    }

    private var frames: [VideoAnimation]?

    init() {
        parent = CALayer()
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