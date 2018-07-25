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
    
    


    @IBOutlet weak var pickerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(scale))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotate))
        let gestureRecognizer1 = UIPanGestureRecognizer(target: self, action: #selector(handlePan1))
        let gestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(handlePan2))
        let gestureRecognizer3 = UIPanGestureRecognizer(target: self, action: #selector(handlePan3))
        let rotationGesture3 = UIRotationGestureRecognizer(target: self, action: #selector(rotate3))
        let pinchGesture3 = UIPinchGestureRecognizer(target: self, action: #selector(scale3))
        //
   
        pinchGesture.delegate = self
        rotationGesture.delegate = self
        pinchGesture.delegate = self
        gestureRecognizer1.delegate = self
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
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.cornerRadius = 10.5
        scrollMaster.layer.borderWidth = 3
        scrollMaster.layer.borderColor = UIColor.white.cgColor
        scrollMaster.layer.cornerRadius = 10
        imageView.addGestureRecognizer(gestureRecognizer2)
        scrollView.addGestureRecognizer(pinchGesture)
        scrollView.addGestureRecognizer(rotationGesture)
        scrollMaster.addSubview(overlay)
        scrollMaster.addSubview(scrollView)
        scrollView.addSubview(imageView)
      
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


@objc func rotate(_ gesture: UIRotationGestureRecognizer) {
       scrollView.transform = scrollView.transform.rotated(by: gesture.rotation)
    }
func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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
          imageView.image = filteredImage
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
