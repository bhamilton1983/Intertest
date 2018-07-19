import Photos
import UIKit
import AVFoundation

class VideoWriter: UIViewController {
// MARK: - Write Images as Movie -

func writeImagesAsMovie(allImages: [UIImage], videoPath: String, videoSize: CGSize, videoFPS: Int32) {
    // Create AVAssetWriter to write video
    guard let assetWriter = createAssetWriter(path: videoPath, size: videoSize) else {
        print("Error converting images to video: AVAssetWriter not created")
        return
    }
    
    // If here, AVAssetWriter exists so create AVAssetWriterInputPixelBufferAdaptor
    let writerInput = assetWriter.inputs.filter { $0.mediaType == AVMediaType.video }.first!
    let sourceBufferAttributes: [String: AnyObject] = [
        kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32ARGB) as AnyObject,
        kCVPixelBufferWidthKey as String: videoSize.width as AnyObject,
        kCVPixelBufferHeightKey as String: videoSize.height as AnyObject
    ]
    let pixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: writerInput, sourcePixelBufferAttributes: sourceBufferAttributes)
    
    // Start writing session
    assetWriter.startWriting()
    assetWriter.startSession(atSourceTime: CMTime.zero)
    if pixelBufferAdaptor.pixelBufferPool == nil {
        print("Error converting images to video: pixelBufferPool nil after starting session")
        return
    }
    
    // -- Create queue for <requestMediaDataWhenReadyOnQueue>
    let mediaQueue = DispatchQueue.init(label: "mediaInputQueue")
    
    // -- Set video parameters
    let frameDuration = CMTime(value: 1, timescale: videoFPS)
    var frameCount = 0
    
    // -- Add images to video
    let numImages = allImages.count
    writerInput.requestMediaDataWhenReady(on: mediaQueue, using: { () -> Void in
        // Append unadded images to video but only while input ready
        while writerInput.isReadyForMoreMediaData && frameCount < numImages {
            let lastFrameTime = CMTime(value: Int64(frameCount), timescale: videoFPS)
            let presentationTime = frameCount == 0 ? lastFrameTime : lastFrameTime.add(frameDuration)
            
            if !self.appendPixelBufferForImageAtURL(image: allImages[frameCount], pixelBufferAdaptor: pixelBufferAdaptor, presentationTime: presentationTime) {
                print("Error converting images to video: AVAssetWriterInputPixelBufferAdapter failed to append pixel buffer")
                return
            }
            
            frameCount += 1
        }
        
        // No more images to add? End video.
        if frameCount >= numImages {
            writerInput.markAsFinished()
            assetWriter.finishWriting {
                if assetWriter.error != nil {
                    print("Error converting images to video: \(assetWriter.error?.localizedDescription ?? "")")
                } else {
                    self.saveVideoToLibrary(videoURL: URL.init(string: videoPath)!)
                    print("Converted images to movie @ \(videoPath)")
                }
            }
        }
    })
}

// MARK: - Create Asset Writer -

func createAssetWriter(path: String, size: CGSize) -> AVAssetWriter? {
    // Convert <path> to NSURL object
    let pathURL = URL.init(fileURLWithPath: path)
    
    // Return new asset writer or nil
    do {
        // Create asset writer
        let newWriter = try AVAssetWriter(outputURL: pathURL, fileType: AVFileType.mp4)
        
        // Define settings for video input
        let videoSettings: [String: AnyObject] = [
            AVVideoCodecKey: AVVideoCodecType.h264 as AnyObject,
            AVVideoWidthKey: size.width as AnyObject,
            AVVideoHeightKey: size.height as AnyObject
        ]
        
        // Add video input to writer
        let assetWriterVideoInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: videoSettings)
        newWriter.add(assetWriterVideoInput)
        
        // Return writer
        print("Created asset writer for \(size.width)x\(size.height) video")
        return newWriter
    } catch {
        print("Error creating asset writer: \(error)")
        return nil
    }
}

// MARK: - Append Pixel Buffer -

func appendPixelBufferForImageAtURL(image: UIImage, pixelBufferAdaptor: AVAssetWriterInputPixelBufferAdaptor, presentationTime: CMTime) -> Bool {
    var appendSucceeded = false
    
    autoreleasepool {
        if  let pixelBufferPool = pixelBufferAdaptor.pixelBufferPool {
            let pixelBufferPointer = UnsafeMutablePointer<CVPixelBuffer?>.allocate(capacity: 1)
            let status: CVReturn = CVPixelBufferPoolCreatePixelBuffer(
                kCFAllocatorDefault,
                pixelBufferPool,
                pixelBufferPointer
            )
            
            if let pixelBuffer = pixelBufferPointer.pointee, status == 0 {
                fillPixelBufferFromImage(image: image, pixelBuffer: pixelBuffer)
                appendSucceeded = pixelBufferAdaptor.append(pixelBuffer, withPresentationTime: presentationTime)
                pixelBufferPointer.deinitialize()
            } else {
                NSLog("Error: Failed to allocate pixel buffer from pool")
            }
            
            pixelBufferPointer.deallocate(capacity: 1)
        }
    }
    
    return appendSucceeded
}

// MARK: - Fill Pixel Buffer -

func fillPixelBufferFromImage(image: UIImage, pixelBuffer: CVPixelBuffer) {
    CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
    
    let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer)
    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    
    // Create CGBitmapContext
    let context = CGContext(
        data: pixelData,
        width: Int(image.size.width),
        height: Int(image.size.height),
        bitsPerComponent: 8,
        bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
        space: rgbColorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue
    )
    
    // Draw image into context"
    context?.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
    
    CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
}

// MARK: - Save Video -

func saveVideoToLibrary(videoURL: URL) {
    PHPhotoLibrary.requestAuthorization { status in
        // Return if unauthorized
        guard status == .authorized else {
            print("Error saving video: unauthorized access")
            return
        }
        
        // If here, save video to library
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
        }, completionHandler: { success, error in
            if !success {
                print("Error saving video: \(error?.localizedDescription ?? "")")
            }
        })
    }
}
}
