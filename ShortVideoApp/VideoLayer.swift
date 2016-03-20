import UIKit
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

    internal func draw() {
        let screen = UIScreen.mainScreen().bounds
        for frame in frames! {
            guard let layer = frame.layer else {
                return
            }
            layer.frame = screen
            parent?.addSublayer(layer)
        }
    }

}