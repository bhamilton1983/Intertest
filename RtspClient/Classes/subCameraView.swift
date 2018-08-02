//
//  subCameraView.swift
//  RtspClient
//
//  Created by Brian Hamilton on 8/1/18.



import UIKit

class subCameraView: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var video:RTSPPlayer!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        video = RTSPPlayer(video: "rtsp://admin:admin@192.168.1.118/videoinput_1/h264_1/media.stm", usesTcp: false)
        video.outputWidth = Int32(1920)
        video.outputHeight = Int32(1080)
        video.seekTime(0.0)
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0/30, target: self, selector: #selector(subCameraView.update), userInfo: nil, repeats: true)
        timer.fire()
    }

        @objc func update(timer: Timer) {
            if(!video.stepFrame()){
            timer.invalidate()
            video.closeAudio()
        }
      
        imageView.image = video.currentImage
    }
    
}
     // Dispose of any resources that can be recreated.

