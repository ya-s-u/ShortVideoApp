import Foundation
import YYImage

class VideoAnimation: Equatable {

    internal var name: String?
    internal var image: YYImage?
    internal var view: YYAnimatedImageView?

    init(name: String) {
        self.name = name
        image = YYImage(named: "\(name).png")
        view = YYAnimatedImageView(image: image)
    }

    internal var layer: CALayer? {
        let count = image?.animatedImageFrameCount()
        var images = [CGImage]()
        var durations = [Double]()
        for i in 0...count!-1 {
            images.append((image?.animatedImageFrameAtIndex(i))!.CGImage!)
            durations.append((image?.animatedImageDurationAtIndex(i))!)
        }

        return CALayer.anime(images, durations: durations)
    }

    internal func start() {
        view?.startAnimating()
    }

    internal func stop() {
        view?.stopAnimating()
    }
}

func == (lhs: VideoAnimation, rhs: VideoAnimation) -> Bool {
    return lhs.name == rhs.name
}
