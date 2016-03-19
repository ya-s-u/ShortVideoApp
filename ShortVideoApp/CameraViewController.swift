import UIKit
import AVFoundation
import APNGKit

class CameraViewController: UIViewController, VideoManagerDelegate {

    @IBOutlet private weak var videoView: UIView!

    private var video: VideoManager?

    override func viewDidLoad() {
        video = VideoManager.sharedInstance
        guard let video = video else {
            return
        }
        video.position = .Front
        let layer = video.layer
        layer.frame = view.frame
        videoView.layer.insertSublayer(layer, below: videoView.layer)

        let image = APNGImage(named: "friend")
        let imageView = APNGImageView(image: image)
        imageView.frame = view.frame
        view.addSubview(imageView)
        imageView.startAnimating()
    }

    @IBAction func tapPlayBtn(sender: AnyObject) {
        video?.capture(2.0)
    }

    func captured(video: AVAsset) {
        print(video)
    }

}
