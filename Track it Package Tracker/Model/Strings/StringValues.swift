//
//  StringLiteral.swift
//  Track It
//
//  Created by Adebayo Sotannde on 1/15/22.
//

struct StringLiteral
{
    //App Name
    static let homeViewControllerTitleName = "Home"
    
    //Notification Keys
    static let notificationKey = "com.tosin.notificationKey"
    static let updateHomeViewData = "updateHomeViewData"
    static let barcodeScannedNotification = "barcodeScannedNotification"
    static let hideHomeViewNavigationBar = "hideHomeViewNavigationBar"
    static let updatePackageViewController = "updatePackageViewController"
    static let postCarrierName = "postCarrierName"
    static let postCarrierCode = "postCarrierCode"
    static let hideSideMenu =  "hideSideMenu"
    static let editTrackingNumber = "editTrackingNumber"
    static let refreshPackageActivityScreen = "refreshPackageActivityScreen"
    
    //Camera
    static let cameraOff = "off"
    static let boltCircleFill = "bolt.circle.fill"
    static let cameraOn = "on"
    static let boltSlashCircleFill = "bolt.slash.circle.fill"
    static let cameraAccessRequestTitle = "📸 ⚙️Need Camera Access "
    static let cameraAccessRequestMessage = "Camera access is reqired to scan barcodes"
    
    //Defaults for aded tracking number. Note: Tracking Number and Description provied by the user
    static let yellowColor = "yellow"
    static let greenColor = "green"
    static let redColor = "red"
    static let defaultDescription = "no data"
    
    //Images
    static let transparantLogo = "transparantLogo"
    static let greenTheme = "greenTheme"
    
    
    //Segue
    static let addParcel = "addParcel"
    static let barcodeScanner = "barcodeScanner"
    
    
    
    //SupportEmail
    static let emailSupportAddress = "trackit.packagetracker@gmail.com"
    static let emailMessage = "<p>Thank you for your support&nbsp;</p><p>Please provide the following details so we can work promptly in adding the carrier</p><p><strong>Carrier Name:</strong></p><p><strong>Sample Tracking Number: </strong></p><p><strong>Carrier Website:</strong></p><p><br></p><p>Thanks you once again. As always all information provided are kept confidential.</p><p><br></p><p>Best Regards,&nbsp;</p><p>Track it! Team.</p>"
    static let emailSubject = "Add Carrier Request"
}
