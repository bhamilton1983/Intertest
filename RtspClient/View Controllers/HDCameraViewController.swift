//
//  HDCameraViewController.swift
//  RtspClient
//
//  Created by Brian Hamilton on 6/5/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//
import Photos
import UIKit
import AVFoundation
import Foundation
import CoreML
import Vision
import ReplayKit
import QuartzCore

class HDCameraViewController: UIViewController, RPPreviewViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate,UIScrollViewDelegate {
   
    
    
    let http = HttpService ()
    let camera = Camera ()
    var video: RTSPPlayer?
    static var timer = Timer()
    var tapToggle = 0
    var identity = CGAffineTransform.identity
    var imagePicker: UIImagePickerController!
    
  
    @IBOutlet weak var textView: UIView!
    @IBOutlet var touch: UIView!
    @IBOutlet weak var cameraScroll: UIScrollView!
    @IBOutlet weak var cropImageView: UIImageView!
    @IBOutlet weak var exposureView: UIView!
    @IBOutlet var HDimageView: UIImageView!
   
    
    @IBOutlet weak var cameraModel: UILabel!
    @IBOutlet weak var ipLabel: UILabel!
    @IBOutlet weak var resolutionLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var faceButton: UIButton!
    @IBOutlet weak var savePhoto: UIButton!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var classificationButton: UIButton!
    
    
  
  
    @IBOutlet weak var playPause: UIButton!
    static var playRate:Double = 0.0
    var toggleState = 1
    @IBOutlet weak var sideControlContainer: UIView!
    @IBAction func playAction(_ sender: Any) {
            starttime()
    }
        @IBAction func stopAction(_ sender: Any) {
        stoptime()
    }
  
    @IBAction func classificationActionButton(_ sender: Any) {
        
        classificationProcess((video?.currentImage)!)
        
    }
    @IBAction func faceAction(_ sender: Any) {
        
        let masterImage = UIImage(view: cameraScroll)
        process(masterImage)
    }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(scale))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotate))
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        gestureRecognizer.delegate = self
        pinchGesture.delegate = self
        rotationGesture.delegate = self
        cameraModel.text = HttpService.camera.CameraModelNumber
        exposureView.layer.borderWidth = 2
        exposureView.layer.borderColor = UIColor.white.cgColor
        cameraScroll.layer.borderColor = UIColor.clear.cgColor
        cameraScroll.layer.borderWidth = 2
        cameraScroll.layer.cornerRadius = 10
        cameraScroll.minimumZoomScale = 0.5
        cameraScroll.maximumZoomScale = 10.0
        cameraScroll.zoomScale = 1.0
        cameraScroll.addGestureRecognizer(tap)
        cameraScroll.addGestureRecognizer(pinchGesture)
        cameraScroll.addGestureRecognizer(longPressRecognizer)
        cameraScroll.addGestureRecognizer(rotationGesture)
        cameraScroll.addGestureRecognizer(gestureRecognizer)
        cameraScroll.addSubview(HDimageView)
        exposureView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.ipLabel.text = Login.ip
            self.cameraModel.text = HttpService.camera.CameraModelNumber
            self.resolutionLabel.text = HttpService.camera.CameraInputFormat
            self.touch.addSubview(self.textView)
        }
    }
    
    @objc func doubleTapped() {
        // do something here
        if tapToggle == 0
        {
            tapToggle = 1
            exposureView.isHidden = true
        }   else  {
            if tapToggle == 1
            {
                exposureView.isHidden = false
                tapToggle = 0
            }
        }
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer)
    {
 
    }
    //save photo to camera roll
    @IBAction func savePhotoTapped(_ sender: Any) {
        let imageRepresentation = HDimageView.image!.pngData()
        let imageData = UIImage(data: imageRepresentation!)
        UIImageWriteToSavedPhotosAlbum(imageData!, nil, nil, nil)
        let alert = UIAlertController(title: "Completed", message: "Image has been saved!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    @objc func rotate(_ gesture: UIRotationGestureRecognizer) {
        cameraScroll.transform = cameraScroll.transform.rotated(by: gesture.rotation)

    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return cameraScroll
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }


    
    @objc func scale(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            identity = cameraScroll.transform
        case .changed,.ended:
           cameraScroll.transform = identity.scaledBy(x: gesture.scale, y: gesture.scale)
        case .cancelled:
            break
        default:
            break
        }
    }

    @IBAction func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: cameraScroll)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: cameraScroll)
        }
    }

        func starttime () {
           
            video = RTSPPlayer(video: "\(Login.rtsp)", usesTcp: false)
            video?.outputWidth = Int32(UIScreen.main.bounds.height)
            video?.outputHeight = Int32(UIScreen.main.bounds.width)
            video?.seekTime(0.0)
            HDCameraViewController.timer = Timer.scheduledTimer(timeInterval: HDCameraViewController.playRate, target: self, selector: #selector( HDCameraViewController.update), userInfo: nil, repeats: true)
                HDCameraViewController.timer.fire()
        }
        
        func stoptime ()    {
            HDCameraViewController.timer.invalidate()
                            }


    @objc func update(timer: Timer) {
     
        do {
            
            try self.video?.stepFrame()
            self.HDimageView.image = self.video?.currentImage
            
            } catch {
                presentAlertController(withTitle: "no video found", message: "check the credentials")
                HDCameraViewController.timer.invalidate()
        }
    
    }

    func classificationProcess(_ image: UIImage) {
        HDimageView.image = image
        
        guard let pixelBuffer = image.pixelBuffer(width: 299, height: 299) else {
            return
        }
        //I have `Use of unresolved identifier 'Inceptionv3'` error here when I use New Build System (File > Project Settings)   ¯\_(ツ)_/¯
        let model = Inceptionv3()
        do {
            let output = try model.prediction(image: pixelBuffer)
            let probs = output.classLabelProbs.sorted { $0.value > $1.value }
            if let prob = probs.first {
                classificationLabel.text = "\(prob.key) \(prob.value)"
            }
        }
        catch {
            self.presentAlertController(withTitle: title,
                                        message: error.localizedDescription)
        }
    }
    
    func process(_ image: UIImage) {
        
        
        cropImageView.image = image
        
        guard let ciImage = CIImage(image: image) else {
            return
        }
        let request = VNDetectFaceRectanglesRequest { [unowned self] request, error in
            if let error = error {
                self.presentAlertController(withTitle: self.title,
                                            message: error.localizedDescription)
            }
            else {
                self.handleFaces(with: request)
            }
        }
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([request])
        }
        catch {
            presentAlertController(withTitle: title,
                                   message: error.localizedDescription)
        }
    }
    
    func handleFaces(with request: VNRequest) {
        cropImageView.layer.sublayers?.forEach { layer in
            layer.removeFromSuperlayer()
        }
        guard let observations = request.results as? [VNFaceObservation] else {
            return
        }
        observations.forEach { observation in
            let boundingBox = observation.boundingBox
            let size = CGSize(width: boundingBox.width * cropImageView.bounds.width,
                              height: boundingBox.height * cropImageView.bounds.height)
            let origin = CGPoint(x: boundingBox.minX * cropImageView.bounds.width,
                                 y: (1 - observation.boundingBox.minY) * cropImageView.bounds.height - size.height)
            
            let layer = CAShapeLayer()
            layer.frame = CGRect(origin: origin, size: size)
            layer.borderColor = UIColor.yellow.cgColor
            layer.borderWidth = 2

            cropImageView.layer.addSublayer(layer)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
    
    
}

