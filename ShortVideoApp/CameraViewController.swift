import UIKit
import AVFoundation

class CameraViewController: UIViewController, VideoManagerDelegate {

    @IBOutlet private weak var videoView: UIView!
    @IBOutlet private weak var playBtn: DesignableButton!

    private var video: VideoManager?
    private var frames: [Animation]?

    override func viewDidLoad() {
        video = VideoManager()
        guard let video = video else {
            return
        }
        video.delegate = self
        video.position = .Front
        let layer = video.layer
        layer.frame = view.frame
        videoView.layer.insertSublayer(layer, below: videoView.layer)

        frames = []
        frames?.append(Animation(name: "friend"))
        frames?.append(Animation(name: "star"))

        drawFrames()
    }

    @IBAction func tapPlayBtn(sender: AnyObject) {
        print("tap")
        video?.capture(2.0)
        playBtn.enabled = false
    }

    func captured(video: AVAsset) {
        print(video)
        playBtn.enabled = true
    }

    func drawFrames() {
        guard let frames = frames else {
            return
        }
        for frame in frames {
            guard let imageView = frame.view else {
                return
            }
            imageView.frame = view.frame
            imageView.startAnimating()
            videoView.addSubview(imageView)
        }
    }

}
