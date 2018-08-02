//
//   static var xPoint:CGFloat = 0.0
//   static var yPoint:CGFloat = 0.0
//   static var rectWidth:CGFloat = 0.0
//   static var rectHeight:CGFloat = 0.0
//   static var rectMade:CGRect = CGRect(x:HDCameraViewController.xPoint, y: HDCameraViewController.yPoint, width: HDCameraViewController.rectWidth, height: HDCameraViewController.rectHeight)
//   static var lastPoint:CGPoint = CGPoint.zero
//   static var currentPoint:CGPoint = CGPoint.zero
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        if let touch = touches.first {
//            HDCameraViewController.lastPoint = touch.location(in: touch.view)
//            print(HDCameraViewController.lastPoint)
//        }
//
//    }
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//
//        //Get the current known point and redraw
//            if let touch = touches.first {
//                HDCameraViewController.currentPoint = touch.location(in: touch.view)
//                    reDrawSelectionArea(fromPoint: HDCameraViewController.lastPoint, toPoint: HDCameraViewController.currentPoint)
//
//        }
//    }
//    func reDrawSelectionArea(fromPoint: CGPoint, toPoint: CGPoint) {
//        overlay.isHidden = false
//        print((HDimageView.image?.size.width)!)
//        print(HDCameraViewController.lastPoint.x)
//        print((HDimageView.image?.size.height)!)
//        print(HDCameraViewController.currentPoint.y)
//        let imageRatio = (HDimageView.image?.size.width)! / (HDimageView.image?.size.height)!
//        print(imageRatio, "imageRatio")
//
//        let widthFactor = ((HDimageView.image?.size.width)!) * imageRatio
//        print(widthFactor, "width")
//        print(HDCameraViewController.lastPoint.x)
//        print(toPoint)
//        let heigthFactor = ((HDimageView.image?.size.height)!) * imageRatio
//        print(heigthFactor, "heigth")
//        print(HDCameraViewController.currentPoint.y)
//        print(HDCameraViewController.yPoint)
//        //Calculate rect from the original point and last known point
//        let rect = CGRect(x:min(fromPoint.x, toPoint.x),
//                          y:min(fromPoint.y, toPoint.y),
//                          width:fabs(fromPoint.x - toPoint.x),
//                          height:fabs(fromPoint.y - toPoint.y));
//        PhotoController.xPoint =  PhotoController.lastPoint.x * imageRatio
//        PhotoController.yPoint =  PhotoController.currentPoint.y * imageRatio
//        PhotoController.rectWidth = (PhotoController.currentPoint.x - PhotoController.lastPoint.x) * widthFactor
//        PhotoController.rectHeight = (PhotoController.currentPoint.y - PhotoController.lastPoint.y) * heigthFactor
//
//        overlay.frame = rect
//    }
////    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        overlay.isHidden = false
//        overlay.frame = CGRect.zero //reset overlay for next tap
//        overlay.layer.borderColor = UIColor.yellow.cgColor
//        overlay.backgroundColor = UIColor.red.withAlphaComponent(0.2)
//
//        cropImageView.image =  cropToBounds(image: HDimageView.image!, rect: overlay.frame)
//        cropImageView.layer.borderWidth = 2
//        cropImageView.layer.cornerRadius = 10
//        cropImageView.layer.borderColor = UIColor.black.cgColor
//        cameraScroll.addSubview(cropImageView)
//    }
