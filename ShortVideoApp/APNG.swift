import Foundation
import APNGKit

class APNG {

    private var name: String?

    init(name: String) {
        self.name = name
    }

    internal var image: APNGImage? {
        guard let name = name else {
            return nil
        }
        return APNGImage(named: name)
    }

}