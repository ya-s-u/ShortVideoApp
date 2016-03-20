import AVFoundation

@objc protocol VideoManagerDelegate {
    optional func finishCapture(video: AVAsset)
}

class VideoManager: NSObject, VideoGrabberDelegate {

    internal var delegate: VideoManagerDelegate?

    private var grabber: VideoGrabber?
    private var composer: VideoComposer?
    private var exporter: VideoExporter?

    private var video: AVAsset?

    override init() {
        super.init()
        grabber = VideoGrabber.sharedInstance
        composer = VideoComposer()
        exporter = VideoExporter()

        grabber?.delegate = self
    }

    internal func setPosition(position: AVCaptureDevicePosition) {
        grabber?.position = position
    }

    internal func getLayer() -> CALayer {
        guard let grabber = grabber else {
            return CALayer()
        }
        return grabber.layer
    }

    internal func startCapture() {
        grabber?.capture()
    }

    internal func captured(video: AVAsset) {
        self.video = video
        delegate?.finishCapture!(video)
    }

    internal func export() {

    }
}