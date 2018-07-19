import UIKit
import CoreML
import CoreImage
import Photos
import Vision
import QuartzCore

class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate {
  
    
    
    @IBOutlet weak var classificationLabel: UILabel!
    
    static var rectMade:CGRect = CGRect(x:PhotoController.xPoint, y: PhotoController.yPoint, width: PhotoController.rectWidth, height: PhotoController.rectHeight)
    @IBOutlet weak var scrollMaster: UIScrollView!
    var identity = CGAffineTransform.identity
    let overlay = UIView()
    static var lastPoint:CGPoint = CGPoint.zero
    static var currentPoint:CGPoint = CGPoint.zero
 
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var scrollViewTwo: UIScrollView!
    
    @IBOutlet weak var secondImage: UIImageView!

    @IBOutlet weak var savePhotoFilter: UIButton!
    @IBOutlet weak var findFace: UIButton!
    @IBOutlet weak var cropButton: UIButton!
    
    static var filterName:String = "CISepiaTone"
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imagePick: UIButton!
  
    static var xPoint:CGFloat = 0.0
    static var yPoint:CGFloat = 0.0
    static var rectWidth:CGFloat = 0.0
    static var rectHeight:CGFloat = 0.0
   
    @IBOutlet weak var classifyButton: UIButton!
    

    @IBAction func classify(_ sender: Any) {
        classificationProcess(imageView.image!)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Get the current known point and redraw
        if let touch = touches.first {
            PhotoController.currentPoint = touch.location(in: imageView)
            reDrawSelectionArea(fromPoint: PhotoController.lastPoint, toPoint: PhotoController.currentPoint)
            
        }
    }
    func reDrawSelectionArea(fromPoint: CGPoint, toPoint: CGPoint) {
        overlay.isHidden = false
        let rect = CGRect(x:min(fromPoint.x, toPoint.x),
                          y:min(fromPoint.y, toPoint.y),
                          width:fabs(fromPoint.x - toPoint.x),
                          height:fabs(fromPoint.y - toPoint.y));
        PhotoController.xPoint =  PhotoController.lastPoint.x
        PhotoController.yPoint =  PhotoController.currentPoint.y
        PhotoController.rectWidth = (PhotoController.currentPoint.x - PhotoController.lastPoint.x)
        PhotoController.rectHeight = (PhotoController.currentPoint.y - PhotoController.lastPoint.y)
        overlay.frame = rect
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        overlay.isHidden = false
        
        
        overlay.frame = CGRect.zero //reset overlay for next tap
    }

    @IBOutlet weak var pickerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(scale))
        let pinchGesture1 = UIPinchGestureRecognizer(target: self, action: #selector(scale1))
        let pinchGesture2 = UIPinchGestureRecognizer(target: self, action: #selector(scale2))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotate))
        let rotationGesture1 = UIRotationGestureRecognizer(target: self, action: #selector(rotate1))
        let rotationGesture2 = UIRotationGestureRecognizer(target: self, action: #selector(rotate2))
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        let gestureRecognizer1 = UIPanGestureRecognizer(target: self, action: #selector(handlePan1))
        let gestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(handlePan2))
        let gestureRecognizer3 = UIPanGestureRecognizer(target: self, action: #selector(handlePan3))
        let rotationGesture3 = UIRotationGestureRecognizer(target: self, action: #selector(rotate3))
        let pinchGesture3 = UIPinchGestureRecognizer(target: self, action: #selector(scale3))
        //
        gestureRecognizer.delegate = self
        pinchGesture.delegate = self
        rotationGesture.delegate = self
        pinchGesture1.delegate = self
        rotationGesture1.delegate = self
        gestureRecognizer1.delegate = self
        rotationGesture2.delegate = self
        gestureRecognizer.delegate = self
        pinchGesture2.delegate = self
        rotationGesture3.delegate = self
        gestureRecognizer3.delegate = self
        pinchGesture3.delegate = self
        //
        //
        scrollMaster.minimumZoomScale = 0.5
        scrollMaster.maximumZoomScale = 10.0
        scrollMaster.zoomScale = 1.0
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 10.0
        scrollView.zoomScale = 1.0
        scrollViewTwo.minimumZoomScale = 0.5
        scrollViewTwo.maximumZoomScale = 10.0
        scrollViewTwo.zoomScale = 1.0
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.green.cgColor
        imageView.layer.cornerRadius = 10.5
        scrollMaster.layer.borderWidth = 3
        scrollMaster.layer.borderColor = UIColor.white.cgColor
        scrollMaster.layer.cornerRadius = 10
        secondImage.layer.borderWidth = 2
        secondImage.layer.borderColor = UIColor.black.cgColor
        secondImage.layer.cornerRadius = 10
        imageView.addGestureRecognizer(pinchGesture2)
        imageView.addGestureRecognizer(rotationGesture2)
        imageView.addGestureRecognizer(gestureRecognizer2)
        secondImage.addGestureRecognizer(pinchGesture3)
        secondImage.addGestureRecognizer(rotationGesture3)
        secondImage.addGestureRecognizer(gestureRecognizer3)
        scrollView.addGestureRecognizer(gestureRecognizer)
        scrollView.addGestureRecognizer(pinchGesture)
        scrollView.addGestureRecognizer(rotationGesture)
        scrollViewTwo.addGestureRecognizer(pinchGesture1)
        scrollViewTwo.addGestureRecognizer(gestureRecognizer1)
        scrollViewTwo.addGestureRecognizer(rotationGesture1)
        scrollMaster.addSubview(overlay)
        scrollMaster.addSubview(scrollView)
        scrollMaster.addSubview(scrollViewTwo)
        scrollView.addSubview(imageView)
        scrollViewTwo.addSubview(secondImage)
      
        
        // OverLay View Setup not being used currently
        overlay.layer.borderColor = UIColor.yellow.cgColor
        overlay.backgroundColor = UIColor.clear.withAlphaComponent(0.2)
        overlay.isHidden = false
        //  var croppedRect:CGRect = CGRect(x: xPoint,y:yPoint,width: rectWidth, height: rectHeight)
    }
 

    @IBAction func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: scrollViewTwo)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: scrollViewTwo)
        }
    }
    @IBAction func handlePan1(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: scrollView)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: scrollView)
        }
    }
    @IBAction func handlePan2(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: scrollMaster)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: scrollMaster)
        }
    }
    @IBAction func handlePan3(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: imageView)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: imageView)
        }
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollMaster
    }



    
    
@objc func scale3(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            identity = imageView.transform
        case .changed,.ended:
           imageView.transform = identity.scaledBy(x: gesture.scale, y: gesture.scale)
        case .cancelled:
            break
        default:
            break
        }
    }
@objc func scale(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            identity = scrollView.transform
        case .changed,.ended:
         scrollView.transform = identity.scaledBy(x: gesture.scale, y: gesture.scale)
        case .cancelled:
            break
        default:
            break
        }
    }
@objc func scale1(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            identity = scrollViewTwo.transform
        case .changed,.ended:
         scrollViewTwo.transform = identity.scaledBy(x: gesture.scale, y: gesture.scale)
        case .cancelled:
            break
        default:
            break
        }
    }
@objc func scale2(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            identity = secondImage.transform
        case .changed,.ended:
            secondImage.transform = identity.scaledBy(x: gesture.scale, y: gesture.scale)
        case .cancelled:
            break
        default:
            break
        }
    }
@objc func rotate(_ gesture: UIRotationGestureRecognizer) {
       scrollView.transform = scrollView.transform.rotated(by: gesture.rotation)
    }
func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
@objc func rotate1(_ gesture: UIRotationGestureRecognizer) {
      secondImage.transform = secondImage.transform.rotated(by: gesture.rotation)
    }
@objc func rotate2(_ gesture: UIRotationGestureRecognizer) {
        scrollMaster.transform = scrollViewTwo.transform.rotated(by: gesture.rotation)
    }
@objc func rotate3(_ gesture: UIRotationGestureRecognizer) {
        imageView.transform = imageView.transform.rotated(by: gesture.rotation)
    }
func gestureRecognizer1(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
func gestureRecognizer3(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
@IBAction func Filter(_ sender: Any) {
       
      
        guard let image = imageView?.image, let cgimg = image.cgImage else {
            print("imageView doesn't have an image!")
            return
            
        }
        
        let coreImage = CIImage(cgImage: cgimg)
        let filter = CIFilter(name: "\(PhotoController.filterName)")
        filter?.setValue(coreImage, forKey: kCIInputImageKey)
                                                            //    filter?.setValue(1.0, forKey: kCIInputIntensityKey)
               if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
            let filteredImage = UIImage(ciImage: output)
            secondImage.image = filteredImage
        }
            
        else {
            print("image filtering failed")
        }
    }
    
    @IBAction func saveFilterPhotoAction(_ sender: Any) {
        let masterImage = UIImage(view: scrollMaster)
        let renderer = UIGraphicsImageRenderer(size: masterImage.size)
        let image = renderer.image { ctx in
           scrollMaster.drawHierarchy(in: scrollMaster.bounds, afterScreenUpdates: true)
        }
        let imageRepresentation = image.pngData()
        let imageData = UIImage(data: imageRepresentation!)
        UIImageWriteToSavedPhotosAlbum(imageData!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Completed", message: "Image has been saved!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //Crop Button, not functioning Properly
    @IBAction func cropAction(_ sender: Any) {
        
        var cropMaster = UIImage(view: scrollMaster)
       cropMaster = cropToBounds(image: cropMaster, rect: scrollMaster.frame)
        overlay.frame = CGRect.zero
        print(PhotoController.xPoint)
        print(PhotoController.yPoint)
        print(PhotoController.rectMade)
        print(imageView.image?.size as Any)
    }
    // Seems to be working
    @IBAction func faceAction(_ sender: Any) {
        let masterImage = UIImage(view: scrollMaster)
        process(masterImage)
    }
    
    func process(_ image: UIImage) {
    
        
      imageView.image = image
        
        
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
       imageView.layer.sublayers?.forEach { layer in
            layer.removeFromSuperlayer()
        }
        guard let observations = request.results as? [VNFaceObservation] else {
            return
        }
        observations.forEach { observation in
            let boundingBox = observation.boundingBox
            let size = CGSize(width: boundingBox.width * imageView.bounds.width,
                              height: boundingBox.height * imageView.bounds.height)
            let origin = CGPoint(x: boundingBox.minX * imageView.bounds.width,
                                 y: (1 - observation.boundingBox.minY) * imageView.bounds.height - size.height)
            
            let layer = CAShapeLayer()
            layer.frame = CGRect(origin: origin, size: size)
            layer.borderColor = UIColor.yellow.cgColor
            layer.borderWidth = 2
            
           imageView.layer.addSublayer(layer)
        }
    }
    
    func cropToBounds(image: UIImage, rect: CGRect) -> UIImage {
       
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
       // let __CGSize__CGSize = contextImage.size
       
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: scrollView.frame)!

        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale,
                                     orientation: image.imageOrientation)
        
        return image
    }


    @IBAction func buttonAction(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .photoLibrary
        }
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
        
}


    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
  
    
    func classificationProcess(_ image: UIImage) {
        
        imageView.image = image
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
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}
