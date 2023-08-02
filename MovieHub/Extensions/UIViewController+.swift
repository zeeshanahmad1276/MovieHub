//
//  UIViewController+.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/2/23.
//

import UIKit

extension UIViewController {
    
    func fullScreePresent(vc:UIViewController) {
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func fullScreeCover(vc:UIViewController,presentFromRoot:Bool = false) {
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func showAlert(title:String?, message:String?,actionTitle:String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
