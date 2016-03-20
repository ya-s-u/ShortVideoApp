import Foundation
import APNGKit

class VideoAnimation: Equatable {

    internal var name: String?
    internal var view: APNGImageView?

    init(name: String) {
        self.name = name
        let image = APNGImage(named: name)
        view = APNGImageView(image: image)
    }

    internal var layer: CALayer? {
        guard let view = view else {
            return CALayer()
        }
        return CALayer.APNG(view.image!.frames)
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