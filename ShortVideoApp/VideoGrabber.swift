import AVFoundation

@objc protocol VideoGrabberDelegate {
    optional func captured(video: AVAsset)
}

class VideoGrabber: NSObject, AVCaptureFileOutputRecordingDelegate {

    static let sharedInstance = VideoGrabber()
    internal var delegate: VideoGrabberDelegate?

    internal var position: AVCaptureDevicePosition? = .Front {
        didSet {
            setup()
        }
    }

    private var device: AVCaptureDevice?
    private var session: AVCaptureSession?
    private var input: AVCaptureInput?
    private var output: AVCaptureMovieFileOutput?

    private override init() {
        super.init()
        setup()
    }

    private func setup() {
        setupCamera()
        setupInput()
        session = AVCaptureSession()
        output = AVCaptureMovieFileOutput()

        guard let session = session else {
            return
        }

        session.addInput(input)
        session.addOutput(output)
        session.startRunning()
    }

    private func setupCamera() {
        let devices = AVCaptureDevice.devices()
        if let idx = devices.indexOf({ $0.position == position }) {
            guard let selected = devices[idx] as? AVCaptureDevice else {
                return
            }
            device = selected
        }
    }

    private func setupInput() {
        do {
            input = try AVCaptureDeviceInput.init(device: device)
        } catch let error as NSError {
            print(error)
        }
    }

    internal var layer: CALayer {
        let layer = AVCaptureVideoPreviewLayer.init(session: session)
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        return layer
    }

    internal func capture(interval: Double = 2.0) {
        guard let output = output else {
            return
        }
        let url = NSURL.tmpFile()
        output.startRecordingToOutputFileURL(url, recordingDelegate: self)
        NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: Selector("finish"), userInfo: nil, repeats: false)
    }

    internal func finish() {
        output?.stopRecording()
    }

    internal func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        let asset = AVAsset(URL: outputFileURL)
        delegate?.captured!(asset)
    }
}