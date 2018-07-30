//
//  IPCellClassTableViewCell.swift
//  RtspClient
//
//  Created by Brian Hamilton on 7/28/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import UIKit
import Foundation

class IPCellClassTableViewCell: UITableViewCell, UITableViewDelegate {

    
    var delegate:UITableViewDelegate?
    
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func buttonTapped(_ sender: Any) {
        Login.ip = LoginTable.ipaddress2!
        Login.rtsp = "rtsp://admin:admin@\(Login.ip)/videoinput_1/h264_1/media.stm"
        print(Login.rtsp)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
