//
//  ViewController.swift
//  HSIIDC
//
//  Created by STTL on 10/07/24.
//

import UIKit

class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var SlideItemCV: UICollectionView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var GridCV: UICollectionView!
    @IBOutlet weak var GridCVheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    
    //Variables
    var slideItemsDataSourceDelegate : SlideItemsDataSourceDelegate!
    var gridItemDataSourceDelegate : GridItemDataSourceDelegate!
    var impLinkDataSourceDelegate : ImpLinkDataSourceDelegate!
    var webService = SlideCVWebServices()
    var arrData : [SlideModel] = []
    var arrGridData : [GridItemModel] = []
    var arrImpLinks : [ImpLinkModel] = []
    var currentCellIndex = 0
    var timer : Timer?
    
    //Main Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        setUpGridView()
        setupTblView()
        
        pageControl.numberOfPages = arrData.count
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        self.changeCollectionHeight()
    }

    //Selector Function
    @objc func slideToNext ()
    {
        if currentCellIndex < arrData.count - 1 {
            currentCellIndex = currentCellIndex + 1
        }else{
            currentCellIndex = 0
        }
        
        pageControl.currentPage = currentCellIndex
        
        // Slide Images
        SlideItemCV.scrollToItem(at: IndexPath(item: currentCellIndex ,section:0), at: .right, animated: true)
    }
    
    //Function For Getting Data from JSON to Dictionary
    func getData(){
        webService.getSlideItemList{ arr in
            arrData = arr
        }
        setUpHorizontalCollectionView()
    }

    // Set up Horizontal collection View
    func setUpHorizontalCollectionView() {
        let width = SlideItemCV.frame.width
        let HeadlineHeight = "abc".height(withConstrainedWidth: width, font: .systemFont(ofSize: 19, weight: .semibold))
        let dateHeight = "abc".height(withConstrainedWidth: width, font: .systemFont(ofSize: 16, weight: .regular))
        let finalHeight = (width/2.2) + (HeadlineHeight*3) + dateHeight + 15
        heightConstraint.constant = finalHeight
        if slideItemsDataSourceDelegate == nil {
            slideItemsDataSourceDelegate = .init(arrData: arrData, delegate: self, col: SlideItemCV,vc:self, height: Float(finalHeight))
        }
    }
    
    //Read PropertyList Function
    func readPropertyList(ofName: String) -> Any? {
        if let path = Bundle.main.path(forResource: ofName, ofType: "plist") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .init(rawValue: 0))
                let plistData = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
                return plistData
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
        return nil
    }
    
    //Set up Grid Collection View
    func setUpGridView(){
        if let arr = readPropertyList(ofName: "GridItemList") as? [[String:Any]] {
            self.arrGridData = arr.map({ GridItemModel(fromDictionary: $0) })
        }
        if gridItemDataSourceDelegate == nil {
            gridItemDataSourceDelegate = .init(arrData: arrGridData, delegate:self,col:GridCV,vc:self)
        }
    }
    
    //SetUP Table Aciton
    func setupTblView(){
        if let arr = readPropertyList(ofName: "ImpLinksList") as? [[String:Any]] {
            self.arrImpLinks = arr.map({ ImpLinkModel(fromDictionary: $0) })
        }
        if impLinkDataSourceDelegate == nil {
            impLinkDataSourceDelegate = .init(arrData: arrImpLinks, delegate: self, tbl: tblView)
        }
    }
    
    func changeCollectionHeight(){
        self.GridCVheightConstraint.constant = GridCV.contentSize.height
        self.tblViewHeightConstraint.constant = tblView.contentSize.height
    }
}

//MARK:- Extension for ColViewDelegate
extension ViewController: ColViewDelegate {
    func didSelect(colView: UICollectionView, indexPath: IndexPath) {
    }
}

//MARK:- Extension for TblViewDelegate
extension ViewController: TblViewDelegate {
    func didselect(tbl: UITableView, indexPath: IndexPath) {
        if let selectedItemString = arrImpLinks[indexPath.row].link,
           let selectedItemURL = URL(string: selectedItemString) {
            UIApplication.shared.open(selectedItemURL)
        } else {
            // Handle the error: the URL is invalid or nil
            print("Invalid URL: \(arrImpLinks[indexPath.row].link ?? "nil")")
        }
    }
}
