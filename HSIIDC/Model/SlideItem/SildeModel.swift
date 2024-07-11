//
//  SildeModel.swift
//  HSIIDC
//
//  Created by STTL on 10/07/24.
//

import Foundation

class SlideModel: NSObject {
    var id:Int32!
    var img:String!
    var headline:String!
    var date:String!
    
    init(fromDictionary dictionary: [String: Any]) {
        id = dictionary["id"] as? Int32
        img = dictionary["img"] as? String
        headline = dictionary["headline"] as? String
        date = dictionary["date"] as? String
    }
}
