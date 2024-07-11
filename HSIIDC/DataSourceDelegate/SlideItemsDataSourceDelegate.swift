//
//  SlideItemsDataSourceDelegate.swift
//  HSIIDC
//
//  Created by STTL on 10/07/24.
//

import Foundation
import UIKit

//Protocol for selection of Row
protocol ColViewDelegate {
    func didSelect(colView: UICollectionView, indexPath: IndexPath)
}

class SlideItemsDataSourceDelegate: NSObject {

    //Datatype Alias
    typealias T = SlideModel
    typealias col = UICollectionView
    typealias del = ColViewDelegate
    typealias vc = UIViewController

    //Variables
    internal var height: Float
    internal var arrSource: [T]
    internal var colvw: col
    internal var delegate: del
    internal weak var vc:vc?

    //Variables with Declaration
    let kNumberOfItemsInOneRow: CGFloat = 1
    let kEdgeInset:CGFloat = 0
    let minimumInterItemandLinespacing:CGFloat = 0

    //MARK:- Initializers
    required init(arrData: [T], delegate: ColViewDelegate, col: UICollectionView,vc:vc, height: Float) {
        arrSource = arrData
        colvw = col
        self.height = height
        self.delegate = delegate
        self.vc = vc
        super.init()
        setupCol()
    }

    //Setup Collection View
    fileprivate func setupCol(){

        let nib = UINib(nibName: "SlideImageCVC", bundle: nil)
        colvw.register(nib, forCellWithReuseIdentifier: "SlideImageCVC")
        colvw.dataSource = self
        colvw.delegate = self
        colvw.reloadData()
    }

    //Reload Collection View
    func reload(arr:[T]){
        arrSource = arr
        colvw.reloadData()
    }
}

//MARK:- Collection View Delegate Extension
extension SlideItemsDataSourceDelegate:UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelect(colView: colvw, indexPath: indexPath)
    }

}

//MARK:- Collection View Datasource Extension
extension SlideItemsDataSourceDelegate:UICollectionViewDataSource {

    //No. of Items in Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSource.count
    }

    //Set value of cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideImageCVC", for: indexPath) as! SlideImageCVC
        cell.configCell(data: arrSource[indexPath.row])
        return cell
    }
}


//MARK:- UICollectionViewDelegateFlowLayout Methods
extension SlideItemsDataSourceDelegate: UICollectionViewDelegateFlowLayout {
    //Minimum Line Spacing For Section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterItemandLinespacing
    }

    //Minimum Spacng Between Items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterItemandLinespacing
    }

    //Size of an Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return .init(width: width, height: CGFloat(height))
    }

    //Whole Section Padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: kEdgeInset, left: kEdgeInset, bottom: kEdgeInset, right: kEdgeInset)
    }
}
