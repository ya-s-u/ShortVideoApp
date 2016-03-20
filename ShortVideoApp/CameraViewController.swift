import UIKit
import AVFoundation

class CameraViewController: UIViewController, VideoManagerDelegate {

    @IBOutlet private weak var videoView: UIView!
    @IBOutlet private weak var playBtn: DesignableButton!

    private var video: VideoManager?
    private var frames: [VideoAnimation]?

    override func viewDidLoad() {
        video = VideoManager()
        guard let video = video else {
            return
        }
        video.delegate = self
        video.position = .Front
        let layer = video.layer
        layer.frame = view.frame
        videoView.layer.addSublayer(layer)

        video.frames?.append(VideoAnimation(name: "friend"))
        video.frames?.append(VideoAnimation(name: "star"))
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

}
