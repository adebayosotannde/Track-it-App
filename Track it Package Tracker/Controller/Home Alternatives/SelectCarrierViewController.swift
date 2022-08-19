//
//  SelectCarrierViewController.swift
//  Track It
//
//  Created by Adebayo Sotannde on 1/17/22.
//
import UIKit
import MessageUI

//MARK: - LyfeCycle Functions
extension SelectCarrierViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()

    }
    
    func setup()
    {
        carriers =  Carrier.supportedSarriers()
        setUpTableView()
        setupSearchBar()
        self.dismissKeyboard() //Dismiss keyboard when not inside the UITextfield

    }
}


//MARK: - Main Class
class SelectCarrierViewController: UIViewController
{
    
    var carriers: [Carrier] = []
    var filteredCarriers: [Carrier] = []
    
    //Varibles used to impement Search Bar
    let searchController = UISearchController(searchResultsController: nil)

    var isSearchBarEmpty: Bool
    {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool
    {
      return searchController.isActive && !isSearchBarEmpty
    }


    
    //IBOUTLETS
    @IBOutlet weak var carrierTableView: UITableView!
    
    //IBACTIONS
    @IBAction func cantFindCarrierButtonPressed(_ sender: Any)
    {
        let alert = UIAlertController(title: "😅 Hey There👋", message: "We apologize for the inconvinence. More Carriers will be added with future updates. Thanks for your understanding.🙏", preferredStyle: UIAlertController.Style.alert)
    
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler:
        { UIAlertAction in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Suggest Carrier", style: .default, handler:
        { UIAlertAction in
            self.sendEmail()
        }))

        self.present(alert, animated: true, completion: nil)//Displays the Alert Box
    }
    
    
}



//MARK: - Table View Functions DataSource and Relevant Functions
extension SelectCarrierViewController: UITableViewDataSource
{
    func setUpTableView()
    {
        registerTableViewCells()
        configureTableView()
    }
    
    private func registerTableViewCells()
    {
        let textFieldCell = UINib(nibName: CarrierTableViewCell.classIdentifier,bundle: nil)
        self.carrierTableView.register(textFieldCell,forCellReuseIdentifier: CarrierTableViewCell.cellIdentifier)
    }

    func configureTableView()
    {
        //Make Table View Look Nice
        carrierTableView.showsVerticalScrollIndicator = false
        carrierTableView.separatorStyle = .none  //Hides the lines
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        if isFiltering
        {
           return filteredCarriers.count
         }

        return carriers.count
    }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //Create Cell
        let cell = carrierTableView.dequeueReusableCell(withIdentifier: CarrierTableViewCell.cellIdentifier) as! CarrierTableViewCell
        
        let carrier: Carrier
          if isFiltering
        {
              carrier = filteredCarriers[indexPath.row]
          } else
        {
              carrier = carriers[indexPath.row]
          }
        
        
        cell.carrierName.text = carrier.name
        cell.carrierImage.image = UIImage(named: carrier.name.lowercased())
//
//        cell.carrierName.text = carriers[indexPath.row].name
//        cell.carrierImage.image = UIImage(named: carriers[indexPath.row].name.lowercased())

        return cell

    }
}

//MARK: - Table View Functions DataSource and Relevant Functions
extension SelectCarrierViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        let carrier: Carrier
          if isFiltering
        {
              carrier = filteredCarriers[indexPath.row]
          } else
        {
              carrier = carriers[indexPath.row]
          }
        
        postBarcodeNotification(carrierName: carrier.name)
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.popViewController(animated: true)
      
    
    }

}

//MARK: - Nofication Center
extension SelectCarrierViewController
{
    func postBarcodeNotification(carrierName: String)
    {
       
        var info = [String: String]()
        info[StringLiteral.postCarrierName] = carrierName.description
        NotificationCenter.default.post(name: Notification.Name(rawValue: StringLiteral.notificationKey), object: nil, userInfo: info)
        AppUtility.toggleHapticSuccess() //Haptic Indicating Success
        
    }
}

//MARK: - Seach Bar Extension relavite functions
extension SelectCarrierViewController: UISearchResultsUpdating
{
    func setupSearchBar()
    {
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Carrier"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
    
        navigationItem.hidesSearchBarWhenScrolling = false

    }
  func updateSearchResults(for searchController: UISearchController)
    {
        //Function is called after a text is typed into the box
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    
    func filterContentForSearchText(_ searchText: String)
    {
        //This functions filters carriers based on the text inside the search bar.
      filteredCarriers = carriers.filter
        { (carrier: Carrier) -> Bool in
        return carrier.name.lowercased().contains(searchText.lowercased())
      }

        carrierTableView.reloadData() //reloads the table view
      
    }

    
}

//MARK: - Seach Bar Extension relavite functions
extension SelectCarrierViewController
{
    
}

//MARK: - Mail Composite Extension
extension SelectCarrierViewController: MFMailComposeViewControllerDelegate
{
    func sendEmail()
    {
        if MFMailComposeViewController.canSendMail()
        {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([StringLiteral.emailSupportAddress])
            mail.setMessageBody(StringLiteral.emailMessage, isHTML: true)
            mail.setSubject(StringLiteral.emailSubject)

            present(mail, animated: true)
        } else
        {
            let alert = UIAlertController(title: "Email Server Error", message: "There is an error sending an email. Please Investigate.", preferredStyle: UIAlertController.Style.alert)
        
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler:
            { UIAlertAction in
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)//Displays the Alert Box
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true)
        print("And error occured")
    }
}

