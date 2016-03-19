import UIKit
import AVFoundation

class CameraViewController: UIViewController, VideoManagerDelegate {

    @IBOutlet private weak var videoView: UIView!

    override func viewDidLoad() {
        let video = VideoManager(position: .Front)
        let layer = video.layer
        layer.frame = view.frame
        videoView.layer.insertSublayer(layer, below: videoView.layer)
    }

    @IBAction func tapPlayBtn(sender: AnyObject) {
        print("play")
    }

    func captured(video: AVAsset) {
        print(video)
    }

}
