import AVFoundation

@objc protocol VideoManagerDelegate {
    optional func captured(video: AVAsset)
}

class VideoManager: NSObject, VideoGrabberDelegate {

    internal var delegate: VideoManagerDelegate?

    private var grabber: VideoGrabber?
    private var vlayer: VideoLayer?
    private var composer: VideoComposer?
    private var exporter: VideoExporter?

    private var video: AVAsset?

    override init() {
        super.init()
        grabber = VideoGrabber.sharedInstance
        composer = VideoComposer()
        exporter = VideoExporter()

        grabber?.delegate = self
        vlayer = VideoLayer()
    }

    internal var position: AVCaptureDevicePosition = .Front {
        didSet {
            grabber?.position = position
        }
    }

    internal var layer: CALayer {
        guard let grabber = grabber else {
            return CALayer()
        }
        vlayer?.video = grabber.layer
        guard let vlayer = vlayer, parent = vlayer.parent else {
            return CALayer()
        }
        return parent
    }

    internal func capture(interval: Double) {
        grabber?.capture(interval)
    }

    internal func captured(video: AVAsset) {
        self.video = video
        delegate?.captured!(video)
    }

    internal func export() {

    }
}