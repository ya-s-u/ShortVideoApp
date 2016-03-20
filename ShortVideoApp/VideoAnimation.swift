import Foundation
import APNGKit

class VideoAnimation {

    private var name: String?
    internal var image: APNGImage?
    internal var view: APNGImageView?

    init(name: String) {
        self.name = name
        image = APNGImage(named: name)
        view = APNGImageView(image: image)
    }

    internal var layer: CALayer? {
        return CALayer()
    }

}