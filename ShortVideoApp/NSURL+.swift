import Foundation

extension NSURL {

    public enum FileType: String {
        case MP4, GIF, MOV

        var pathPhrase: String {
            return rawValue.lowercaseString
        }
    }

    class func tmp(filetype: FileType) -> NSURL? {
        let directory = NSTemporaryDirectory()
        let fileName = NSUUID().UUIDString
        let url = NSURL.fileURLWithPathComponents([directory, "\(fileName).\(filetype.pathPhrase)"])
        return url
    }

}