import YYImage

class VideoExporter {

    internal func export(images: [UIImage]) {
        let encode = YYImageEncoder(type: .GIF)
        encode?.quality = 1.0
        encode?.loopCount = 3
        images.forEach { encode?.addImage($0, duration: 0.3) }

        let path = NSURL.tmp(.GIF)?.absoluteString
        encode?.encodeToFile(path!)
    }

}