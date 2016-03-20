import Foundation
import APNGKit

class VideoAnimation {

    private var name: String?
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
        let img = view.image?.frames.first?.image
        let layer = CALayer()
        layer.contents = img!.CGImage
//        return layer
        return CALayer.APNG(view.image!.frames)
    }

    internal func start() {
        view?.startAnimating()
    }

    internal func stop() {
        view?.stopAnimating()
    }

}