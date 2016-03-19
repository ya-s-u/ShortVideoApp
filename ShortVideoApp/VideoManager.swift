import UIKit
import AVFoundation

@objc protocol VideoManagerDelegate {
    optional func captured(video: AVAsset)
}

class VideoManager: NSObject, AVCaptureFileOutputRecordingDelegate {

    private var delegate: VideoManagerDelegate?

    private var position: AVCaptureDevicePosition?
    private var device: AVCaptureDevice?
    private var session: AVCaptureSession?
    private var input: AVCaptureInput?
    private var output: AVCaptureMovieFileOutput?

    init(position: AVCaptureDevicePosition) {
        super.init()
        self.position = position

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

    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        let asset = AVAsset(URL: outputFileURL)
        self.delegate?.captured!(asset)
    }
}