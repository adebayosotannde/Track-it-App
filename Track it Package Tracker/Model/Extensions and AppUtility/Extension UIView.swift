//
//  UIView.swift
//  Track It
//
//  Created by Adebayo Sotannde on 1/17/22.
//
import UIKit

extension UIView
{
    @IBInspectable var cornerRadius: CGFloat
    {
        get
        {
            return self.cornerRadius
            
        }
        set
        {
            self.layer.cornerRadius = newValue
        }
    }
    
  
         func blink()
    {
       
             self.alpha = 0.2
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
         }
    
}

extension UIViewController
{
    
}

