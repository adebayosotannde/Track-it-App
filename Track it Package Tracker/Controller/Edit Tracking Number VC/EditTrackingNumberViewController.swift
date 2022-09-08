//
//  AddTrakingNumberViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/3/22.
//

import UIKit
import Contacts
import CoreData

extension EditTrackingNumberViewController
{
    override func viewDidLoad()
    {

        registerNotificationCenter()
        barcodeButton.blink()
        self.carrierNameLabel.delegate = self
       
        
        
        setUpEditTrackingNumberViewController()
   
    }
    
    func setUpEditTrackingNumberViewController()
    {
        trackingNumberLabel.text = passedPackage?.trackingNumber
        carrierNameLabel.text = passedPackage?.carrierName
        packageDescriptionLabel.text = passedPackage?.descriptionOfPackage
        carrierImage.image = UIImage(named: (passedPackage?.packageCarrierCode)!)
        
    }

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)

        if (launchBarcodeViewController == true)
        {
            self.performSegue(withIdentifier: StringLiteral.barcodeScanner, sender: self)
            launchBarcodeViewController = false
        }
    }
    
    
    func enableButton()
    {
        startTrackingButton.isEnabled = true
        startTrackingButton.alpha = 1.0
    }
    
    func disableButton()
    {
        startTrackingButton.isEnabled = false
        startTrackingButton.alpha = 0.5
    }
}

class EditTrackingNumberViewController: UIViewController
{
    //MARK: - Variables and Constants
    var passedPackage:PackageObject?
    var indexPassed = 0
    var pacakges = [PackageObject]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var launchBarcodeViewController = false
    
    @IBAction func buttonTracking(_ sender: Any)
    {
        
       
        textFieldCheck()
    }
    //Package Details
    var carrierCode: String = ""
    var carrierName: String = ""
    var trackingNumber: String = ""
    var packageDescription: String = ""
    
    
    


    //IBOUTLETS

    @IBOutlet weak var startTrackingButton: UIButton!
    @IBOutlet weak var carrierImage: UIImageView!
    //UITextFileds
    @IBOutlet weak var barcodeButton: UIButton!
    @IBOutlet weak var carrierNameLabel: UITextField!
    
    @IBOutlet weak var packageDescriptionLabel: UITextField!
    @IBOutlet weak var trackingNumberLabel: UITextField!

    @IBAction func startTrackingButtonPressed(_ sender: Any)
    {
        //TODO:
        createNewPackageObject()
        dismissViewController()
        
       
       
    }
    @IBAction func barcodeButtonPressed(_ sender: UIButton)
    {
        print("Barcode Button Pressed")
    }
    
    
}

//MARK: - Notification Canter
extension EditTrackingNumberViewController
{
    func registerNotificationCenter()
    {
    //Obsereves the Notification
    NotificationCenter.default.addObserver(self, selector: #selector(doWhenNotified(_:)), name: Notification.Name(StringLiteral.notificationKey), object: nil)
    }

    func postBarcodeNotification(code: String)
    {
      
        var info = [String: String]()
        info[code.description] = code.description //post the notification with the key.
        NotificationCenter.default.post(name: Notification.Name(rawValue: StringLiteral.notificationKey), object: nil, userInfo: info)
    }

    @objc func doWhenNotified(_ notiofication: NSNotification)
    {

     
      if let dict = notiofication.userInfo as NSDictionary?
      {
          if let carrier = dict[StringLiteral.postCarrierName] as? String
        {
           carrierNameLabel.text = carrier
              carrierName = carrier
              textFieldCheck()
            
        }
          if let carrierCode = dict[StringLiteral.postCarrierCode] as? String
        {
           
              carrierImage.image = UIImage(named: carrierCode.lowercased())
              //Update the carrier Code Variable
              self.carrierCode = carrierCode
        }
          if let barcode = dict[StringLiteral.barcodeScannedNotification] as? String
        {
              trackingNumberLabel.text = barcode
        }
      }
    }
}

extension EditTrackingNumberViewController: UITextFieldDelegate
{
    

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SelectCarrierViewController") as! SelectCarrierViewController
//        navigationController?.pushViewController(newViewController, animated: true)
//           return false

//        performSegue(withIdentifier: "mySegueID", sender: nil)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let newViewController = storyBoard.instantiateViewController(withIdentifier: "SelectCarrierViewController") as! SelectCarrierViewController
               navigationController?.pushViewController(newViewController, animated: true)
                  return false
      

       }
    
    func textFieldCheck()
    {
        if (trackingNumberLabel.text!.isEmpty ) ||  (carrierNameLabel.text!.isEmpty) || (packageDescriptionLabel.text!.isEmpty)
                {
                    disableButton()
                }
                else
                {
                    enableButton()
                }
        
        
                
    }
}


