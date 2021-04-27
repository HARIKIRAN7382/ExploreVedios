//
//  UIViewControllerExtesntion.swift
//  ExploreVedios
//
//  Created by iOS Developer on 27/04/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    enum ToastPosition {
        case top
        case middle
        case bottom
    }

    func showToast(message : String, font: UIFont,toastPosition:ToastPosition) {
        DispatchQueue.main.async {
            let toastLabel = UILabel()
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.numberOfLines = 0
            toastLabel.font = font
            toastLabel.textAlignment = .center;
            toastLabel.text = " " + message + " "
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            toastLabel.translatesAutoresizingMaskIntoConstraints = false

            toastLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            toastLabel.widthAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75).isActive = true
            
            if(toastPosition == ToastPosition.bottom){
                toastLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: self.view.centerYAnchor,multiplier: 0.35).isActive = true
            }else if(toastPosition == ToastPosition.middle){
                toastLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            }else{
                toastLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: self.view.centerYAnchor,multiplier: 0.75).isActive = true
            }
            
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })

        }
    }
    
}
