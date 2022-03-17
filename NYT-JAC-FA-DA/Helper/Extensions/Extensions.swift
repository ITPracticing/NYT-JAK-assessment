//
//  File.swift
//  NYT-JAC-FA-DA
//
//  Created by F_Sur on 17/03/2022.
//

import UIKit

// Blinking Button
extension UIView {
    func btnBlink() {
        self.alpha = 0.2
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear], animations: {self.alpha = 1.0 }, completion: nil)
    }
}

// Present alert
extension UIViewController {

    func presentAlert(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertVC.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertVC, animated: true, completion: nil)
    }
}

// Show and Remove Spinner
fileprivate var spinnerViwe: UIView?
    
extension UIViewController {
        
    public func showSpinner() {
        spinnerViwe = UIView(frame: self.view.bounds)
        spinnerViwe!.backgroundColor = #colorLiteral(red: 0.6061688066, green: 0.6535500288, blue: 0.7366984487, alpha: 1)
        spinnerViwe!.alpha = 0.2
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = spinnerViwe!.center
        ai.color = .black
        ai.startAnimating()
        spinnerViwe!.addSubview(ai)
        self.view.addSubview(spinnerViwe!)
        
        Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { (t) in
            self.removeSpinner()
        }
    }
    public func removeSpinner() {
        spinnerViwe?.removeFromSuperview()
        spinnerViwe = nil
    }
}
