//
//  SlideCVWebServices.swift
//  HSIIDC
//
//  Created by STTL on 10/07/24.
//

import Foundation

class SlideCVWebServices: NSObject {
    
    //Get SlideItems List in Dictionary Datatype
    func getSlideItemList(block : ([SlideModel]) -> Swift.Void){
        var responsemodel = [SlideModel]()
        let dict = readJsonFile(ofName: "slideItemList")
        if let arr = dict["SlideItems"] as? [[String : Any]] {
            responsemodel = arr.map({SlideModel(fromDictionary: $0)})
        }
        block(responsemodel)
    }
    
    //Read Data from Json FIle
    func readJsonFile(ofName: String) -> [String : Any] {
        guard let strPath = Bundle.main.path(forResource: ofName, ofType: ".json") else {
            return [:]
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: strPath), options: .alwaysMapped)
            
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let dictJson = jsonResult as? [String : Any] {
                return dictJson
            }
        } catch {
            print("Error!! Unable to parse ")
        }
        return [:]
    }
}
