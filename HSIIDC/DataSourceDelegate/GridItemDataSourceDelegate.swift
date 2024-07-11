//
//  GridItemDataSourceDelegate.swift
//  HSIIDC
//
//  Created by STTL on 10/07/24.
//

import Foundation
import UIKit

class GridItemDataSourceDelegate: NSObject {
    
    //Datatype Alias
//    typealias T = UserModel
    typealias T = GridItemModel
    typealias col = UICollectionView
    typealias del = ColViewDelegate
    typealias vc = UIViewController
    
    //Internal Variables
    internal var arrSource: [T]
    internal var colvw: col
    internal var delegate: del
    internal weak var vc:vc?
    
    //Variables
    let kNumberOfItemsInOneRow: CGFloat = 2
    let kEdgeInset:CGFloat = 16
    let minimumInterItemandLinespacing:CGFloat = 18
    let minimumSectionLinespacing:CGFloat = 12
    
    //MARK:- Initializers
    required init(arrData: [T], delegate: ColViewDelegate, col: UICollectionView,vc:vc) {
        arrSource = arrData
        colvw = col
        self.delegate = delegate
        self.vc = vc
        super.init()
        setupCol()
    }
    
    //SetUp Collection VIew
    fileprivate func setupCol(){
        let nib = UINib(nibName: "GridItemCVC", bundle: nil)
        colvw.register(nib, forCellWithReuseIdentifier: "GridItemCVC")
        colvw.dataSource = self
        colvw.delegate = self
        colvw.reloadData()
    }
    
    //Reload CollectionView
    func reload(arr:[T]){
        arrSource = arr
        colvw.reloadData()
    }
}

//MARK:- Extension for Collection View delegate
extension GridItemDataSourceDelegate:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelect(colView: colvw, indexPath: indexPath)
    }
    
}

//MARK:- Extension for Collection View DataSource
extension GridItemDataSourceDelegate:UICollectionViewDataSource {
    
    //No. of Items in Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    //Values Of Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridItemCVC", for: indexPath) as! GridItemCVC
        cell.configCell(data: arrSource[indexPath.row])
        return cell
    }
}


//MARK:- UICollectionViewDelegateFlowLayout Methods
extension GridItemDataSourceDelegate: UICollectionViewDelegateFlowLayout {
    
    //Minimum Line Spacing For Section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSectionLinespacing
    }
    
    //Minimum Spacing Between Items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterItemandLinespacing
    }
    
    //Size of an Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 50) / kNumberOfItemsInOneRow
        let height = (width / 2)
        let lineHeight = "dhruv".height(withConstrainedWidth: width, font: .systemFont(ofSize: 17, weight: .regular))
        return .init(width: width, height: height + lineHeight)
    }
    
    //Whole Section Padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: kEdgeInset, left: kEdgeInset, bottom: kEdgeInset, right: kEdgeInset)
    }
}


