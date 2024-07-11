//
//  Navigation.swift
//  DhruvApp
//
//  Created by STTL on 11/04/24.
//

import UIKit

class Navigation{
    
    //Navigation Function : Use to navigate to Other StoryBoard
    //params : (storyboard , viewController , currentViewControlller)
    static func navigateToOtherController(_ storyBoard : String,_ viewController: String, from currentViewController: UIViewController) {
        let sb = UIStoryboard(name:storyBoard,bundle: nil)
        let vc = sb.instantiateViewController(identifier: viewController)
        currentViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    //Navigation Function : Use to navigate to Other StoryBoard
    //params : (storyboard , viewController , currentNavigationController)
    static func navigateToOtherControllerTableView(_ storyBoard : String,_ viewController: String, from currentNavigationController: UINavigationController) {
        let sb = UIStoryboard(name:storyBoard,bundle: nil)
        let vc = sb.instantiateViewController(identifier: viewController)
        currentNavigationController.pushViewController(vc, animated: true)
    }
    
}

