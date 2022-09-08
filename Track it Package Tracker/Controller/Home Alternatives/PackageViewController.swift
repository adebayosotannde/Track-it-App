//
//  PackageViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/11/22.
//

import UIKit
import MapKit

class PackageViewController: UIViewController
{
    var passedPackage:PackageObject?
    var lastLocation: String?
    
    
    @IBOutlet weak var websiteLogo: UIImageView!
    @IBOutlet weak var lastUpdated: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var estimatedDeliverDateLabel: UILabel!
    @IBOutlet weak var longDescriptionView: UIView!
    @IBOutlet weak var longDescriptiopnlayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var packgeTableViewController: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initialSetup()
        lastLocation = (passedPackage?.lastLocation)
       
        
    }
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
        print("Hello")
    }
    
    @IBAction func editButtonPressed(_ sender: Any)
    {


        let alertController = UIAlertController(title: "Shipment Settings", message: "Choose and Action", preferredStyle: .actionSheet)
        
//        let alertController = UIAlertController()
        
        let logoutAction = UIAlertAction(title: "Edit Shipment", style: .default)
        { (action) in
            //Handle Edit Shipement Action
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let editBarcodeViewController = storyBoard.instantiateViewController(withIdentifier: "EditTrackingNumberViewController") as! EditTrackingNumberViewController
            editBarcodeViewController.passedPackage = self.passedPackage
            
            self.navigationController?.pushViewController(editBarcodeViewController, animated: true)
        }
        // add the logout action to the alert controller
        alertController.addAction(logoutAction)
        
        
        if passedPackage?.delivered == true
        {
            
        }
        else
        {
            let logoutAction2 = UIAlertAction(title: "Mark Delivered", style: .default)
            { (action) in
                // handle case of user logging out
                self.passedPackage?.delivered = true
            }
            // add the logout action to the alert controller
            alertController.addAction(logoutAction2)
        }
        
      
        
        
        
//        let logoutAction3 = UIAlertAction(title: "Delete", style: .destructive)
//        { [self] (action) in
//            // Delete Package
//
//            self.navigationController?.popViewController(animated: true)
//            let copy = passedPackage
//            CoreDataManager.sharedManager.delete(person: copy!)
//
//
//        }
//        // add the logout action to the alert controller
//        alertController.addAction(logoutAction3)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle case of user canceling. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alert controller
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        {
            // optional code for what happens after the alert controller has finished presenting
        }
        
    }
    
}
//MARK: - Set UP Functions
extension PackageViewController
{
    func initialSetup()
    {
     registerNotificationCenter() //Notification Center
     //setupRefreshControl()  //Refresh Control
     setUpTableView() //Table View Setuo
    settup()
       
        
    
    }
    
    
    func settup()
    {
        setTitle()
         setLogoLabel()
         setLastupdated()
         setMapViewLocation()
         setDeliveryDate()
         setTransitStatus()
         setErrorMessageView()
        CoreDataManager.sharedManager.updateTrackingNumber(updateThis: passedPackage!) //Checks for updates
    }
    
    func updatePageWithObject()
    {
        setTitle()
         setLogoLabel()
         setLastupdated()

         setDeliveryDate()
         setTransitStatus()
         setErrorMessageView()
        packgeTableViewController.reloadData() //Additional
    }
    
    func setUpTableView()
    {
        registerTableViewCells()
        configureTableView()
    }
    
    func setTitle()
    {
        navigationItem.title =  passedPackage?.trackingNumber!
    }
    func setLastupdated()
    {
        lastUpdated.text = passedPackage?.lastUpdated
    }
    func setLogoLabel()
    {
        websiteLogo.image = UIImage(named: (passedPackage?.packageCarrierCode)!) //sets the image that users can click on to take them to the carriers webite.
    }
    
    func setMapViewLocation()
    {
        var address = passedPackage?.lastLocation
        print("LAst Location \(address)")
        let geocoder = CLGeocoder()
        
        if address == nil
        {
            address = "NY, NY"
        }
            geocoder.geocodeAddressString(address!)
            {
                placemarks, error in
                let placemark = placemarks?.first
               var lat = placemark?.location?.coordinate.latitude
               var lon = placemark?.location?.coordinate.longitude
             
                if lat == nil || lon == nil
                {
                    lat = 39.999733
                    lon = -98.6785034
                }
                
               let center = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self.mapView.setRegion(region, animated: true)
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
                self.mapView.addAnnotation(annotation)
            }
    }
    
    func setDeliveryDate()
    {
        let data: DataObjectManager = DataObjectManager(package: passedPackage!)
        estimatedDeliverDateLabel.text = data.isThereAnDeliveryDateAvailabe()
    }
    
    func setTransitStatus()
    {
        let data: DataObjectManager = DataObjectManager(package: passedPackage!)
        estimatedDeliverDateLabel.adjustsFontSizeToFitWidth =  true
        estimatedDeliverDateLabel.minimumScaleFactor = 0.2
        
        if passedPackage?.isValidTrackingNumber == false
        {
          
            longDescriptionView.backgroundColor = .systemRed
        }
        else
        {
            
                longDescriptionView.backgroundColor = data.getDescriptionBackGroundColor()
            currentImage.image = UIImage(systemName: data.getBestImage())
                
 
        }
        
    }
    
    func setErrorMessageView()
    {
        if passedPackage?.isValidTrackingNumber == false
        {
            
        }
        else
        {
            longDescriptiopnlayoutConstraint.constant = 0 //Hides it essentially.
        }
    }
}


//MARK: - Notification Canter
extension PackageViewController
{
    
    ///- Function allows the view controller to respond to notification requests.
    func registerNotificationCenter()
    {
    //Obsereves the Notification
    NotificationCenter.default.addObserver(self, selector: #selector(doWhenNotified(_:)), name: Notification.Name(StringLiteral.notificationKey), object: nil)
    }
    
    
    
    func postBarcodeNotification(code: String)
    {
        var info = [String: String]()
        info[code.description] = code.description //Notification to post
        NotificationCenter.default.post(name: Notification.Name(rawValue: StringLiteral.notificationKey), object: nil, userInfo: info)
    }
    
    

    @objc func doWhenNotified(_ notiofication: NSNotification)
    {
      
        if let dict = notiofication.userInfo as NSDictionary?
        {
            if let dict = notiofication.userInfo as NSDictionary?
            {
                if (dict[StringLiteral.refreshPackageActivityScreen] as? String) != nil
              {
              initialSetup()
              }
                
                if (dict[StringLiteral.updatePackageViewController] as? String) != nil
                {
                    
                    updatePageWithObject()
                    
                    //This allows the user to move the map and only updates if a new location is observerd
                    //Note: Since the Refresh Controller will cause an update from the notification center is is crutial that the ui is responsive while the user is inside of it.
                    if lastLocation == passedPackage?.lastLocation
                    {
                    }
                    else
                    {
                        setMapViewLocation()
                    }
                    
                    
                   
                    
                }
                
            
        }
    }
    
}
    
    
    public func updateUI()
    {
        //Reload Table View with the new non updated packages array]
       
        packgeTableViewController.reloadData()
        
    }

}


//MARK: - Table View Functions DataSource and Relevant Functions
extension PackageViewController: UITableViewDataSource
{
    
    func registerTableViewCells()
    {
        let textFieldCell = UINib(nibName: ActivityTableViewCell.classIdentifier,bundle: nil)
        self.packgeTableViewController.register(textFieldCell,forCellReuseIdentifier: ActivityTableViewCell.cellIdentifier)
    }
    
    func configureTableView()
    {
        //Makes The table View look nice
        packgeTableViewController.showsVerticalScrollIndicator = false
        packgeTableViewController.separatorStyle = .none  //Hides the lines
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if passedPackage?.isValidTrackingNumber == false
        {
            return 0
        }
        
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPackage?.testData)!)
        print(trackingData)
        let count = (trackingData?.trackingHistory!.count)! - 1
        
        
      
        if count <= 0
        {
            return 0
        }
    
        print("Coiunt is \(count)")
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    
        //Create Cell First
        let cell = packgeTableViewController.dequeueReusableCell(withIdentifier: ActivityTableViewCell.cellIdentifier) as! ActivityTableViewCell
        
        //Set Data Here
        let data: DataObjectManager = DataObjectManager(package: passedPackage!)
        cell.descriptionLabel.text = data.getDescriptionLabelForCell(indexPath: indexPath)
        cell.locationLabel.text = data.getLocationLabelForCel(indexPath: indexPath)
        cell.dateLabel.text = data.getDateForCell(indexPath: indexPath)
        cell.timeLabel.text = data.getTimeForCell(indexPath: indexPath)
    
        return cell
    }
    
}

//MARK: - Table View Functions DataSource and Relevant Functions
extension PackageViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120
        //return 110 //Origina. Return
    }
}


