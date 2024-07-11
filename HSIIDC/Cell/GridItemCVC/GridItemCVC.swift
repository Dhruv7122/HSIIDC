//
//  GridItemCVC.swift
//  HSIIDC
//
//  Created by STTL on 10/07/24.
//

import UIKit

class GridItemCVC: UICollectionViewCell {

    //outlets
    @IBOutlet weak var imgGridItem: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    //main method
    override func awakeFromNib() {
        super.awakeFromNib()
        BorderFactory.addBorder(to: viewContainer, cornerRadius: 12.0, borderColor: UIColor.link, borderWidth: 2.0)
    }
    
    func configCell(data:GridItemModel){
        imgGridItem.image = UIImage(named: data.img)
        lblName.text = data.name
    }

}
