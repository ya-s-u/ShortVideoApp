import Foundation

extension NSURL {

    class func tmpMP4() -> NSURL? {
        let directory = NSTemporaryDirectory()
        let fileName = NSUUID().UUIDString
        let url = NSURL.fileURLWithPathComponents([directory, "\(fileName).mp4"])
        return url
    }

}