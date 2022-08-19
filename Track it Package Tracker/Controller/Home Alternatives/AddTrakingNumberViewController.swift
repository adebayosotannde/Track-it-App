//
//  AddTrakingNumberViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/3/22.
//

import UIKit
import Contacts

extension AddTrakingNumberViewController
{
    override func viewDidLoad()
    {

        registerNotificationCenter()
        barcodeButton.blink()
        self.carrierNameLabel.delegate = self
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
}

class AddTrakingNumberViewController: UIViewController
{

    var launchBarcodeViewController = false


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
    }
    @IBAction func barcodeButtonPressed(_ sender: UIButton)
    {
        print("Barcode Button Pressed")
    }
}

//MARK: - Notification Canter
extension AddTrakingNumberViewController
{
    func registerNotificationCenter()
    {
    //Obsereves the Notification
    NotificationCenter.default.addObserver(self, selector: #selector(doWhenNotified(_:)), name: Notification.Name(StringLiteral.notificationKey), object: nil)
    }

    func postBarcodeNotification(code: String)
    {
        print("Im Here2")
        var info = [String: String]()
        info[code.description] = code.description //post the notification with the key.
        NotificationCenter.default.post(name: Notification.Name(rawValue: StringLiteral.notificationKey), object: nil, userInfo: info)
    }

    @objc func doWhenNotified(_ notiofication: NSNotification)
    {

        print("Im Here")
      if let dict = notiofication.userInfo as NSDictionary?
      {
          if let carrier = dict[StringLiteral.postCarrierName] as? String
        {
           carrierNameLabel.text = carrier
            carrierImage.image = UIImage(named: carrier.lowercased())
        }
          if let barcode = dict[StringLiteral.barcodeScannedNotification] as? String
        {
              trackingNumberLabel.text = barcode
        }
      }
    }
}

extension AddTrakingNumberViewController: UITextFieldDelegate
{

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SelectCarrierViewController") as! SelectCarrierViewController
//        navigationController?.pushViewController(newViewController, animated: true)
//           return false
        print("You touched me!")
//        performSegue(withIdentifier: "mySegueID", sender: nil)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let newViewController = storyBoard.instantiateViewController(withIdentifier: "SelectCarrierViewController") as! SelectCarrierViewController
               navigationController?.pushViewController(newViewController, animated: true)
                  return false
      

       }
}



