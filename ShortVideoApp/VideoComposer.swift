import AVFoundation
import AssetsLibrary
import UIKit

class VideoComposer {

    private var video: AVAsset?

    private var mixComposition = AVMutableComposition()
    private var mainCompositionInstruction = AVMutableVideoComposition()
    
    private var isPortrait = false
    private var naturalSize = CGSize()

    init(video: AVAsset) {
        self.video = video
        setup()
    }

    private func setup() {
        guard let video = video else {
            return
        }

        let trackID = CMPersistentTrackID(kCMPersistentTrackID_Invalid)
        let videoTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeVideo, preferredTrackID: trackID)
        do {
            let timeRange = CMTimeRangeMake(kCMTimeZero, video.duration)
            try videoTrack.insertTimeRange(timeRange, ofTrack: video.tracks.first!, atTime: kCMTimeZero)
        } catch let error as NSError {
            print(error)
        }

        mainCompositionInstruction.instructions = [mainInstruction]

        if isPortrait {
            naturalSize = CGSizeMake(videoAssetTrack.naturalSize.height, videoAssetTrack.naturalSize.width)
        } else {
            naturalSize = videoAssetTrack.naturalSize
        }

        mainCompositionInstruction.renderSize = CGSizeMake(naturalSize.width, naturalSize.height)
        mainCompositionInstruction.frameDuration = CMTimeMake(1, 30)
    }

    private var videoAssetTrack: AVAssetTrack {
        return video!.tracksWithMediaType(AVMediaTypeVideo).first!
    }

    private var mainInstruction: AVMutableVideoCompositionInstruction {
        let mainInstruction = AVMutableVideoCompositionInstruction()
        mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, mixComposition.duration)
        mainInstruction.layerInstructions = [videoLayerInstruction]

        return mainInstruction
    }

    private var videoLayerInstruction: AVMutableVideoCompositionLayerInstruction {
        let videoLayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: video!.tracks.first!)
        let videoTransform = videoAssetTrack.preferredTransform

        if videoTransform.a == 0 && videoTransform.b == 1.0 && videoTransform.c == -1.0 && videoTransform.d == 0 {
            isPortrait = true
        }
        if videoTransform.a == 0 && videoTransform.b == -1.0 && videoTransform.c == 1.0 && videoTransform.d == 0 {
            isPortrait = true
        }

        videoLayerInstruction.setTransform(videoAssetTrack.preferredTransform, atTime: kCMTimeZero)
        videoLayerInstruction.setOpacity(0.0, atTime: video!.duration)

        return videoLayerInstruction
    }

    internal func applyLayer(overlay: CALayer) {
        let parentLayer = CALayer()
        let videoLayer = CALayer()
        parentLayer.frame = CGRectMake(0, 0, naturalSize.width, naturalSize.height)
        videoLayer.frame = CGRectMake(0, 0, naturalSize.width, naturalSize.height)
        parentLayer.addSublayer(videoLayer)

        overlay.frame = CGRectMake(0, 0, naturalSize.width, naturalSize.height)
        parentLayer.addSublayer(overlay)

        mainCompositionInstruction.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, inLayer: parentLayer)
    }

    internal func export() {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        let url = "\(documentsDirectory)/movie.mp4"

        if (NSFileManager.defaultManager().fileExistsAtPath(url)) {
            let manager = NSFileManager.defaultManager()
            do {
                try manager.removeItemAtPath(url)
            } catch let error as NSError {
                print(error)
            }
        }

        let exporter = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)
        exporter?.outputURL = NSURL(fileURLWithPath: url)
        exporter!.outputFileType = AVFileTypeMPEG4
        exporter!.shouldOptimizeForNetworkUse = true
        exporter!.videoComposition = mainCompositionInstruction

        exporter!.exportAsynchronouslyWithCompletionHandler { () -> Void in
            switch exporter!.status {
            case AVAssetExportSessionStatus.Completed:
                print("completed")
                let assetsLib = ALAssetsLibrary()
                assetsLib.writeVideoAtPathToSavedPhotosAlbum(NSURL(fileURLWithPath: url), completionBlock: { (nsurl, error) -> Void in
                    print("done")
                })
                break
            case AVAssetExportSessionStatus.Failed:
                print("failed")
                break
            case AVAssetExportSessionStatus.Cancelled:
                print("cancelled")
                break
            default:
                print("default")
                break
            }
        }
    }

}