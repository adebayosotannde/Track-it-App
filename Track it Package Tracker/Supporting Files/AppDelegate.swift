//
//  AppDelegate.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/1/22.
//

import UIKit
import CoreData
import Firebase
import Siren
import Foundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate
{
    //Variables
    static let sharedManager = AppDelegate() //Create Instance of Persistance
    let userNotificationCenter = UNUserNotificationCenter.current()
    var orientationLock = UIInterfaceOrientationMask .portrait

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Enable Background Refresh
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)

            UIApplication.shared.setMinimumBackgroundFetchInterval(3600)
        
       
        requestNotficationPermission() //Request notification permission
        registerFirebaseDatabase() //Sets up Firebase Notifications
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>)
    {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    //USED TO SET ORIENTATION THAT ARE ALLOWED. NOTE: This applies to all screens
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
    {
            return self.orientationLock
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "Track_it_Package_Tracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
    
    
    //MARK: - Ap Refresh Function
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {

      

      
        CoreDataManager.sharedManager.fetchDataForAllPackages()
        sendNotification()
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
}

//MARK: - USer Notification
extension AppDelegate
{
    /**
     Request permission from the user to display notifications
     */
    func requestNotficationPermission()
    {
        //Request Nottification
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    private func registerFirebaseDatabase()
    {
        //MARK: - Configure Firebase
        FirebaseApp.configure()
        let db = Firestore.firestore()
    }
    
    /**
     Sends a generic notification to the user
     */
    func sendNotification()
    {
        
       
        
        // Create new notifcation content instance
        let notificationContent = UNMutableNotificationContent()

        // Add the content to the notification content
        notificationContent.title = "Your Package is moving 🚚 "
        notificationContent.body = "Check Status"
        notificationContent.badge = NSNumber(value: 0)

        // Add an attachment to the notification content
        if let url = Bundle.main.url(forResource: "dune",
                                        withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "dune",
                                                                url: url,
                                                                options: nil) {
                notificationContent.attachments = [attachment]
            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)
   
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    
    }
    
    
    
    // This method is called when user clicked on the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        coordinateToSomeVC()
    }

    private func coordinateToSomeVC()
    {
        guard let window = UIApplication.shared.keyWindow else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let yourVC = storyboard.instantiateViewController(identifier: "HomeMenuViewController")
        
        let navController = UINavigationController(rootViewController: yourVC)
        navController.modalPresentationStyle = .fullScreen

        // you can assign your vc directly or push it in navigation stack as follows:
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    
    
   
}

//MARK: - Siren Functions
extension AppDelegate
{
    func setupSirenUpdates()
    {
        //MARK: - Siren
        Siren.shared.wail() //Siren import statement.
        //Update Message Presented to User.
        Siren.shared.presentationManager = PresentationManager(alertTintColor: .systemBlue, appName: "UPS Tracker", alertTitle: "A New Version is Available", alertMessage: "A new version of the app is available. Please update as soon as possible. Thank you", updateButtonTitle: "Update", nextTimeButtonTitle: "Not Now", skipButtonTitle: "Skip this Version", forceLanguageLocalization: .none)
       
        Siren.shared.rulesManager = RulesManager(globalRules: .annoying, showAlertAfterCurrentVersionHasBeenReleasedForDays: 1) //Waits 1 days after update release to upgrade user.
    }
}
