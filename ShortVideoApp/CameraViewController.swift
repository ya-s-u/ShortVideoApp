import UIKit
import AVFoundation
import APNGKit

class CameraViewController: UIViewController, VideoManagerDelegate {

    @IBOutlet private weak var videoView: UIView!

    private var video: VideoManager?
    private var frames: [APNGImage]?

    override func viewDidLoad() {
        video = VideoManager.sharedInstance
        guard let video = video else {
            return
        }
        video.position = .Front
        let layer = video.layer
        layer.frame = view.frame
        videoView.layer.insertSublayer(layer, below: videoView.layer)

        frames = []
        frames?.append(APNGImage(named: "friend")!)
        frames?.append(APNGImage(named: "star")!)

        drawFrames()
    }

    @IBAction func tapPlayBtn(sender: AnyObject) {
        print("tap")
        video?.capture(2.0)
    }

    func captured(video: AVAsset) {
        print(video)
    }

    func drawFrames() {
        guard let frames = frames else {
            return
        }
        for frame in frames {
            let imageView = APNGImageView(image: frame)
            imageView.frame = view.frame
            imageView.startAnimating()
            videoView.addSubview(imageView)
        }
    }

}
