import Foundation
import APNGKit

class APNG {

    private var name: String?
    internal var image: APNGImage?
    internal var view: APNGImageView?

    init(name: String) {
        self.name = name
        image = APNGImage(named: name)
        view = APNGImageView(image: image)
    }

}