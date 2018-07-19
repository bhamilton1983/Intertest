//
//  HDCameraViewController.swift
//  RtspClient
//
//  Created by Brian Hamilton on 6/5/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import CoreML
import Vision
import ReplayKit
import QuartzCore

class HDCameraViewController: UIViewController, RPPreviewViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate,UIScrollViewDelegate {
   
    
    
    
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet var touch: UIView!
    let overlay = UIView()
    @IBOutlet weak var cameraScroll: UIScrollView!
    @IBOutlet weak var cropImageView: UIImageView!
    @IBOutlet weak var faceButton: UIButton!
    
    var tapToggle = 0
    var identity = CGAffineTransform.identity
    var imagePicker: UIImagePickerController!
    
   
    @IBOutlet weak var exposureView: UIView!
    
   
   
    @IBOutlet var HDimageView: UIImageView!
    var video: RTSPPlayer?
    static var timer = Timer()
    @IBOutlet weak var playPause: UIButton!
    static var playRate:Double = 0.0
    var toggleState = 1

    
    @IBOutlet weak var zoomControlContainer: UIView!
    @IBOutlet weak var sideControlContainer: UIView!
    @IBAction func playAction(_ sender: Any) {
    
            starttime()
    }
        @IBAction func stopAction(_ sender: Any) {
        stoptime()
    }
    
   static var xPoint:CGFloat = 0.0
   static var yPoint:CGFloat = 0.0
   static var rectWidth:CGFloat = 0.0
   static var rectHeight:CGFloat = 0.0
   static var rectMade:CGRect = CGRect(x:HDCameraViewController.xPoint, y: HDCameraViewController.yPoint, width: HDCameraViewController.rectWidth, height: HDCameraViewController.rectHeight)
   static var lastPoint:CGPoint = CGPoint.zero
   static var currentPoint:CGPoint = CGPoint.zero
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        if let touch = touches.first {
            HDCameraViewController.lastPoint = touch.location(in: touch.view)
            print(HDCameraViewController.lastPoint)
        }
    
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       
        //Get the current known point and redraw
            if let touch = touches.first {
                HDCameraViewController.currentPoint = touch.location(in: touch.view)
                reDrawSelectionArea(fromPoint: HDCameraViewController.lastPoint, toPoint: HDCameraViewController.currentPoint)
                
        }
    }
    func reDrawSelectionArea(fromPoint: CGPoint, toPoint: CGPoint) {
        overlay.isHidden = false
        print((HDimageView.image?.size.width)!)
        print(HDCameraViewController.lastPoint.x)
        print((HDimageView.image?.size.height)!)
        print(HDCameraViewController.currentPoint.y)
        let imageRatio = (HDimageView.image?.size.width)! / (HDimageView.image?.size.height)!
        print(imageRatio, "imageRatio")
  
        let widthFactor = ((HDimageView.image?.size.width)!) * imageRatio
        print(widthFactor, "width")
        print(HDCameraViewController.lastPoint.x)
        print(toPoint)
        let heigthFactor = ((HDimageView.image?.size.height)!) * imageRatio
        print(heigthFactor, "heigth")
        print(HDCameraViewController.currentPoint.y)
        print(HDCameraViewController.yPoint)
        //Calculate rect from the original point and last known point
        let rect = CGRect(x:min(fromPoint.x, toPoint.x),
                          y:min(fromPoint.y, toPoint.y),
                          width:fabs(fromPoint.x - toPoint.x),
                          height:fabs(fromPoint.y - toPoint.y));
        PhotoController.xPoint =  PhotoController.lastPoint.x * imageRatio
        PhotoController.yPoint =  PhotoController.currentPoint.y * imageRatio
        PhotoController.rectWidth = (PhotoController.currentPoint.x - PhotoController.lastPoint.x) * widthFactor
        PhotoController.rectHeight = (PhotoController.currentPoint.y - PhotoController.lastPoint.y) * heigthFactor
        
        overlay.frame = rect
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        overlay.isHidden = false
        overlay.frame = CGRect.zero //reset overlay for next tap
        overlay.layer.borderColor = UIColor.yellow.cgColor
        overlay.backgroundColor = UIColor.red.withAlphaComponent(0.2)
    
        cropImageView.image =  cropToBounds(image: HDimageView.image!, rect: overlay.frame)
        cropImageView.layer.borderWidth = 2
        cropImageView.layer.cornerRadius = 10
        cropImageView.layer.borderColor = UIColor.black.cgColor
        cameraScroll.addSubview(cropImageView)
    }
    


 
    @IBOutlet weak var savePhoto: UIButton!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var classificationButton: UIButton!
    @IBAction func classificationActionButton(_ sender: Any) {
        
        classificationProcess((video?.currentImage)!)
        
    }
    @IBAction func faceAction(_ sender: Any) {
        
        let masterImage = UIImage(view: cameraScroll)
        process(masterImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //set up scroll layer
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(scale))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotate))
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
   
        
        gestureRecognizer.delegate = self
        pinchGesture.delegate = self
        rotationGesture.delegate = self
   
       exposureView.layer.borderWidth = 2
       exposureView.layer.borderColor = UIColor.white.cgColor
       cameraScroll.layer.borderColor = UIColor.black.cgColor
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
       cameraScroll.addSubview(overlay)
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
        let imageRepresentation = HDimageView.image!.pngData()
        let imageData = UIImage(data: imageRepresentation!)
        UIImageWriteToSavedPhotosAlbum(imageData!, nil, nil, nil)
        let alert = UIAlertController(title: "Completed", message: "Image has been saved!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
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
        
        func stoptime () {
            
            HDCameraViewController.timer.invalidate()
        }


    @objc func update(timer: Timer) {
     
        do {
            
            try self.video?.stepFrame()
            self.HDimageView.image = self.video?.currentImage
        } catch {
            
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
    
    func cropToBounds(image: UIImage, rect: CGRect) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        // let __CGSize__CGSize = contextImage.size
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: cameraScroll.frame)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale,
                                     orientation: image.imageOrientation)
        
        return image
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
        // Dispose of any resources that can be recreated.
    }
    
    
}
