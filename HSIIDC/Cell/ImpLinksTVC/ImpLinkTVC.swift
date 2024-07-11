//
//  ImpLinkTVC.swift
//  HSIIDC
//
//  Created by STTL on 10/07/24.
//

import UIKit

class ImpLinkTVC: UITableViewCell {
    
    //outlets
    @IBOutlet weak var lblLink: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCell(data:ImpLinkModel){
        lblLink.text = data.name
    }
    
}
