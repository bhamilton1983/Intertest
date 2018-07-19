import Foundation
import UIKit

public class Plot_Demo: UIView
{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ frame: CGRect) {
        let h = frame.height
        let w = frame.width
        let color:UIColor = UIColor.yellow
        
        let drect = CGRect(x: (w * 0.25), y: (h * 0.25), width: (w * 0.5), height: (h * 0.5))
        let bpath:UIBezierPath = UIBezierPath(rect: drect)
        
        color.set()
        bpath.stroke()
        
        print("it ran")
        NSLog("drawRect has updated the view")
    }
}
public class DrawView: UIView {
    
    var touch : UITouch!
    var lineArray : [[CGPoint]] = [[CGPoint]()]
    var index = -1
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = touches.first! as UITouch
        let lastPoint = touch.location(in: self)
        
        index += 1
        lineArray.append([CGPoint]())
        lineArray[index].append(lastPoint)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = touches.first! as UITouch
        let currentPoint = touch.location(in: self)
        
        self.setNeedsDisplay()
        
        lineArray[index].append(currentPoint)
        
    }
    
    override public func draw(_ rect: CGRect) {
        
        if(index >= 0){
            let context = UIGraphicsGetCurrentContext()
            context!.setLineWidth(5)
            context!.setStrokeColor((UIColor(red:0.00, green:0.38, blue:0.83, alpha:1.0)).cgColor)
            context!.setLineCap(.round)
            
            var j = 0
            while( j <= index ){
                context!.beginPath()
                var i = 0
                context?.move(to: lineArray[j][0])
                while(i < lineArray[j].count){
                    context?.addLine(to: lineArray[j][i])
                    i += 1
                }
                
                context!.strokePath()
                j += 1
                
            }
            
            
        }
        
        
}
}
class DraggableImageView: UIImageView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = .blue
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = .green
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let position = touches.first?.location(in: superview){
            center = position
        }
    }
}
