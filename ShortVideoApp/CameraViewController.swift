import UIKit
import AVFoundation

class CameraViewController: UIViewController, VideoManagerDelegate {

    @IBOutlet private weak var videoView: UIView!
    @IBOutlet private weak var playBtn: DesignableButton!

    private var videoManager: VideoManager?
    private var frames: [VideoAnimation]?

    override func viewDidLoad() {
        videoManager = VideoManager()
        guard let videoManager = videoManager else {
            return
        }
        videoManager.delegate = self
        videoManager.position = .Front
        let layer = videoManager.layer
        layer.frame = view.frame
        videoView.layer.addSublayer(layer)

        videoManager.addFrame(VideoAnimation(name: "friend"))
        videoManager.addFrame(VideoAnimation(name: "star"))

        videoManager.draw()
    }

    @IBAction func tapPlayBtn(sender: AnyObject) {
        print("tap")
        videoManager?.capture(2.0)
        playBtn.enabled = false
    }

    func captured(video: AVAsset) {
        print(video)
        playBtn.enabled = true
        videoManager?.export()
    }

}
