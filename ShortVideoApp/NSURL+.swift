import Foundation

extension NSURL {

    class func tmpFile() -> NSURL? {
        let directory = NSTemporaryDirectory()
        let fileName = NSUUID().UUIDString
        let url = NSURL.fileURLWithPathComponents([directory, fileName])
        return url
    }

}