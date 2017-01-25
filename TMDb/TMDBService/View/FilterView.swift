//
//  FilterView.swift
//  TMDb
//
//  Created by Faris Abu Saleem on 1/25/17.
//  Copyright © 2017 360. All rights reserved.
//

import UIKit

protocol FilterDelegate {
    func onFilterPressed(MaxYear maxYear:String , minYear:String)
}

class FilterView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var containterView: UIView!
    @IBOutlet private weak var textFieldMaxYear: UITextField!
    @IBOutlet private weak var textFieldMinYear: UITextField!
    
    var delegate: FilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containterView.layer.cornerRadius = 8
        containterView.layer.masksToBounds = true
        
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        
        self.showAnimate()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        textFieldMaxYear.delegate = self
        textFieldMinYear.delegate = self
    }
    
    @IBAction func closePopUp(sender: AnyObject) {
        self.removeAnimate()
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        var maxYear = ""
        var minYear = ""
        
        var error = 0
        
        if let year = textFieldMaxYear.text where year != ""
        {
            maxYear = year
        }else{
            error += 1
        }
        
        if let year = textFieldMinYear.text where year != ""
        {
            minYear = year
        }else{
            error += 1
        }
        
        if error > 1 {
            showMessage("Please enter value for MaxYear or MinYear")
            return
        }
        
        delegate?.onFilterPressed(MaxYear: maxYear, minYear: minYear)
        removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    func showMessage(messsage:String){
        let alert = UIAlertController(title: "Filter" , message: messsage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
