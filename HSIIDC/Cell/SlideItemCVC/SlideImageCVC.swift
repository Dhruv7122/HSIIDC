//
//  SlideImageCVC.swift
//  HSIIDC
//
//  Created by STTL on 10/07/24.
//

import UIKit

class SlideImageCVC: UICollectionViewCell {

    //Outlets
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblHeadLine: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    //Variables
    var textToShare = ""
    
    //Main Method
    override func awakeFromNib() {
        super.awakeFromNib()
//        BorderFactory.addBorder(to: viewContainer, cornerRadius: 0, borderColor: UIColor.black, borderWidth: 1.0)
    }
    
    //Share Button CLick Action
    @IBAction func shareBtnAction(_ sender: Any) {
        guard let viewController = parentViewController else {
            print("Parent view controller not found.")
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        viewController.present(activityViewController, animated: true, completion: nil)
    }
    
    //Config Cell Function
    func configCell(data:SlideModel){
        img.image = UIImage(named: data.img)
        textToShare = data.headline + " Date : " + data.date
        lblHeadLine.text = data.headline
        lblDate.text = data.date
    }

}
