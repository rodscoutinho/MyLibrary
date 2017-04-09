//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 21/03/17.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        readBooksDefaultData()
        readMembersDefaultData()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func readBooksDefaultData() {
        
        if UserDefaults.standard.bool(forKey: "Books") {
            return
        }
        
        let book1 = BookMO(context: persistentContainer.viewContext)
        book1.author = "Moran, Cathleen"
        book1.genre = "Childrens"
        book1.title = "Grumpy Cat: Misadventures"
        book1.isbn = "9-13485-062-1"
        
        let book2 = BookMO(context: persistentContainer.viewContext)
        book2.author = "Leon, Elvis"
        book2.genre = "Action and Adventure"
        book2.title = "The Giving Tree"
        book2.isbn = "7-96810-292-6"
        
//        let book3 = BookMO(context: persistentContainer.viewContext)
//        book3.author = "Ware, Kimberly"
//        book3.genre = "Action and Adventure"
//        book3.title = "The Giving Tree"
//        book3.isbn = "7-96810-292-6"
//        
//        let book4 = BookMO(context: persistentContainer.viewContext)
//        book4.author = "Olsen, Ursula"
//        book4.genre = "Action and Adventure"
//        book4.title = "This Savage Song"
//        book4.isbn = "4-36857-462-7"
        
        let book5 = BookMO(context: persistentContainer.viewContext)
        book5.author = "Moran, Cathleen"
        book5.genre = "Childrens"
        book5.title = "Grumpy Cat: Misadventures"
        book5.isbn = "9-13485-062-1"
        
//        let book6 = BookMO(context: persistentContainer.viewContext)
//        book6.author = "Moran, Cathleen"
//        book6.genre = "Childrens"
//        book6.title = "Grumpy Cat: Misadventures"
//        book6.isbn = "9-13485-062-1"
//        
//        let book7 = BookMO(context: persistentContainer.viewContext)
//        book7.author = "Moran, Cathleen"
//        book7.genre = "Childrens"
//        book7.title = "Grumpy Cat: Misadventures"
//        book7.isbn = "9-13485-062-1"
        
        let book8 = BookMO(context: persistentContainer.viewContext)
        book8.author = "Wise, Edward"
        book8.genre = "Satire"
        book8.title = "This Is Not My Hat"
        book8.isbn = "4-69511-812-5"
        
        let book9 = BookMO(context: persistentContainer.viewContext)
        book9.author = "Davis, Tanek"
        book9.genre = "Action and Adventure"
        book9.title = "I Am the Messenger"
        book9.isbn = "1-10893-277-9"
        
        let book10 = BookMO(context: persistentContainer.viewContext)
        book10.author = "Cash, Barbara"
        book10.genre = "Science fiction"
        book10.title = "Harry Potter And The Half Blood Prince"
        book10.isbn = "1-51108-970-8"
        
//        let book11 = BookMO(context: persistentContainer.viewContext)
//        book11.author = "Cash, Barbara"
//        book11.genre = "Science fiction"
//        book11.title = "Harry Potter And The Half Blood Prince"
//        book11.isbn = "1-51108-970-8"
//        
//        let book12 = BookMO(context: persistentContainer.viewContext)
//        book12.author = "Cash, Barbara"
//        book12.genre = "Science fiction"
//        book12.title = "Harry Potter And The Half Blood Prince"
//        book12.isbn = "1-51108-970-8"
//        
//        let book13 = BookMO(context: persistentContainer.viewContext)
//        book13.author = "Cash, Barbara"
//        book13.genre = "Science fiction"
//        book13.title = "Harry Potter And The Half Blood Prince"
//        book13.isbn = "1-51108-970-8"
//        
//        let book14 = BookMO(context: persistentContainer.viewContext)
//        book14.author = "Cash, Barbara"
//        book14.genre = "Science fiction"
//        book14.title = "Harry Potter And The Half Blood Prince"
//        book14.isbn = "1-51108-970-8"
//        
//        let book15 = BookMO(context: persistentContainer.viewContext)
//        book15.author = "Cash, Barbara"
//        book15.genre = "Science fiction"
//        book15.title = "Harry Potter And The Half Blood Prince"
//        book15.isbn = "1-51108-970-8"
//        
//        let book16 = BookMO(context: persistentContainer.viewContext)
//        book16.author = "Cash, Barbara"
//        book16.genre = "Science fiction"
//        book16.title = "Harry Potter And The Half Blood Prince"
//        book16.isbn = "1-51108-970-8"
        
        let book17 = BookMO(context: persistentContainer.viewContext)
        book17.author = "Moran, Cathleen"
        book17.genre = "Science fiction"
        book17.title = "Canada 150 - Colouring our History"
        book17.isbn = "3-90983-714-2"
        
        let book18 = BookMO(context: persistentContainer.viewContext)
        book18.author = "Moran, Cathleen"
        book18.genre = "Science fiction"
        book18.title = "Canada Year by Year"
        book18.isbn = "4-98367-400-9"
        
        let book19 = BookMO(context: persistentContainer.viewContext)
        book19.author = "Moran, Cathleen"
        book19.genre = "Satire"
        book19.title = "Shin-Chis Canoe"
        book19.isbn = "6-53322-000-8"
        
        let book20 = BookMO(context: persistentContainer.viewContext)
        book20.author = "Kane, Isaac"
        book20.genre = "Satire"
        book20.title = "When I Was Eight"
        book20.isbn = "8-80186-294-4"
        
        let book21 = BookMO(context: persistentContainer.viewContext)
        book21.author = "Moran, Cathleen"
        book21.genre = "Science fiction"
        book21.title = "Alberta: Revised"
        book21.isbn = "5-36781-945-9"
        
        let book22 = BookMO(context: persistentContainer.viewContext)
        book22.author = "Moran, Cathleen"
        book22.genre = "Fantasy"
        book22.title = "Who Was Queen Elizabeth?"
        book22.isbn = "3-35190-101-6"
        
        let book23 = BookMO(context: persistentContainer.viewContext)
        book23.author = "Moran, Cathleen"
        book23.genre = "Satire"
        book23.title = "Salt to the Sea"
        book23.isbn = "6-25942-160-3"
        
        let book24 = BookMO(context: persistentContainer.viewContext)
        book24.author = "Moran, Cathleen"
        book24.genre = "Science fiction"
        book24.title = "History Year by Year"
        book24.isbn = "6-19946-821-8"
        
        let book25 = BookMO(context: persistentContainer.viewContext)
        book25.author = "Moran, Cathleen"
        book25.genre = "Romance"
        book25.title = "Not My Girl"
        book25.isbn = "7-88184-267-0"
        
//        let book26 = BookMO(context: persistentContainer.viewContext)
//        book26.author = "Moran, Cathleen"
//        book26.genre = "Science fiction"
//        book26.title = "Alberta: Revised"
//        book26.isbn = "5-36781-945-9"
        
//        let book27 = BookMO(context: persistentContainer.viewContext)
//        book27.author = "Kane, Isaac"
//        book27.genre = "Satire"
//        book27.title = "When I Was Eight"
//        book27.isbn = "8-80186-294-4"
        
//        let book28 = BookMO(context: persistentContainer.viewContext)
//        book28.author = "Kane, Isaac"
//        book28.genre = "Satire"
//        book28.title = "When I Was Eight"
//        book28.isbn = "8-80186-294-4"
        
//        let book29 = BookMO(context: persistentContainer.viewContext)
//        book29.author = "Kane, Isaac"
//        book29.genre = "Satire"
//        book29.title = "When I Was Eight"
//        book29.isbn = "8-80186-294-4"
//        
//        let book30 = BookMO(context: persistentContainer.viewContext)
//        book30.author = "Kane, Isaac"
//        book30.genre = "Satire"
//        book30.title = "When I Was Eight"
//        book30.isbn = "8-80186-294-4"
        
        let book31 = BookMO(context: persistentContainer.viewContext)
        book31.author = "Moran, Cathleen"
        book31.genre = "Science fiction"
        book31.title = "Caraval"
        book31.isbn = "2-38422-947-5"
        
//        let book32 = BookMO(context: persistentContainer.viewContext)
//        book32.author = "Cash, Barbara"
//        book32.genre = "Science fiction"
//        book32.title = "The Ultimate Book of Cities"
//        book32.isbn = "7-82967-486-2"
        
        let book33 = BookMO(context: persistentContainer.viewContext)
        book33.author = "Cash, Barbara"
        book33.genre = "Childrens"
        book33.title = "Pete the Cat and the Cool Cat Boogie"
        book33.isbn = "1-84749-125-7"
        
        let book34 = BookMO(context: persistentContainer.viewContext)
        book34.author = "Cash, Barbara"
        book34.genre = "Romance"
        book34.title = "Beautiful Oops!"
        book34.isbn = "7-25964-669-8"
        
        let book35 = BookMO(context: persistentContainer.viewContext)
        book35.author = "Cash, Barbara"
        book35.genre = "Childrens"
        book35.title = "Harry Potter: Coloring Book"
        book35.isbn = "5-23902-861-6"
        
        let book36 = BookMO(context: persistentContainer.viewContext)
        book36.author = "Cash, Barbara"
        book36.genre = "Childrens"
        book36.title = "Littlest Pet Shop: I Love to Draw!"
        book36.isbn = "9-30738-187-0"
        
        let book37 = BookMO(context: persistentContainer.viewContext)
        book37.author = "Cash, Barbara"
        book37.genre = "Horror"
        book37.title = "A Court of Wings and Ruin"
        book37.isbn = "5-78424-598-3"
        
        let book38 = BookMO(context: persistentContainer.viewContext)
        book38.author = "Trevino, Leila"
        book38.genre = "Science fiction"
        book38.title = "Light in the Lions Den"
        book38.isbn = "6-73473-052-3"
        
//        let book39 = BookMO(context: persistentContainer.viewContext)
//        book39.author = "Trevino, Leila"
//        book39.genre = "Science fiction"
//        book39.title = "Light in the Lions Den"
//        book39.isbn = "6-73473-052-3"
//        
//        let book40 = BookMO(context: persistentContainer.viewContext)
//        book40.author = "Trevino, Leila"
//        book40.genre = "Science fiction"
//        book40.title = "Light in the Lions Den"
//        book40.isbn = "6-73473-052-3"
        
        saveContext()
        
        UserDefaults.standard.set(true, forKey: "Books")
        
    }
    
    private func readMembersDefaultData() {
        
        if UserDefaults.standard.bool(forKey: "Members") {
            return
        }
        
        let member1 = MemberMO(context: persistentContainer.viewContext)
        member1.name = "Kathleen Anderson"
        member1.phone = "46-(758)991-2359"
        member1.address = "5 Hovde Court"
        member1.email = "kanderson0@twitter.com"
        
        let member2 = MemberMO(context: persistentContainer.viewContext)
        member2.name = "Amanda Howard"
        member2.phone = "33-(883)176-6858"
        member2.address = "58 Acker Point"
        member2.email = "ahoward1@icio.us"
        
        let member3 = MemberMO(context: persistentContainer.viewContext)
        member3.name = "Lori Cole"
        member3.phone = "63-(156)294-5781"
        member3.address = "3147 Bluestem Center"
        member3.email = "lcole2@disqus.com"
        
        let member4 = MemberMO(context: persistentContainer.viewContext)
        member4.name = "Roger Davis"
        member4.phone = "48-(328)432-8941"
        member4.address = "18707 Park Meadow Plaza"
        member4.email = "rdavis3@feedburner.com"
        
        let member5 = MemberMO(context: persistentContainer.viewContext)
        member5.name = "Johnny Garcia"
        member5.phone = "55-(417)988-8905"
        member5.address = "859 Sundown Crossing"
        member5.email = "jgarcia4@ca.gov"
        
        let member6 = MemberMO(context: persistentContainer.viewContext)
        member6.name = "Lisa Hunt"
        member6.phone = "593-(333)464-3634"
        member6.address = "73761 Hayes Alley"
        member6.email = "lhunt5@gmpg.org"
        
        let member7 = MemberMO(context: persistentContainer.viewContext)
        member7.name = "Marie Scott"
        member7.phone = "86-(647)173-8552"
        member7.address = "13963 Anzinger Junction"
        member7.email = "mscott6@sfgate.com"
        
        let member8 = MemberMO(context: persistentContainer.viewContext)
        member8.name = "Amanda Hayes"
        member8.phone = "62-(121)870-3352"
        member8.address = "7516 Westerfield Way"
        member8.email = "ahayes7@gnu.org"
        
        let member9 = MemberMO(context: persistentContainer.viewContext)
        member9.name = "Ronald Ryan"
        member9.phone = "86-(841)779-5131"
        member9.address = "3573 Kedzie Lane"
        member9.email = "rryan8@mysql.com"
        
        let member10 = MemberMO(context: persistentContainer.viewContext)
        member10.name = "Tammy Oliver"
        member10.phone = "94-(352)375-5540"
        member10.address = "8 Warner Street"
        member10.email = "toliver9@yolasite.com"
        
        let member11 = MemberMO(context: persistentContainer.viewContext)
        member11.name = "Andrea Ward"
        member11.phone = "223-(586)161-7269"
        member11.address = "0944 Dunning Plaza"
        member11.email = "awarda@google.cn"
        
        let member12 = MemberMO(context: persistentContainer.viewContext)
        member12.name = "Amy Nguyen"
        member12.phone = "86-(291)219-5665"
        member12.address = "554 Katie Alley"
        member12.email = "anguyenb@odnoklassniki.ru"
        
        let member13 = MemberMO(context: persistentContainer.viewContext)
        member13.name = "Edward George"
        member13.phone = "357-(313)154-2776"
        member13.address = "74484 Anhalt Hill"
        member13.email = "egeorgec@pcworld.com"
        
        let member14 = MemberMO(context: persistentContainer.viewContext)
        member14.name = "Lawrence Reed"
        member14.phone = "386-(184)468-5402"
        member14.address = "2 Lindbergh Way"
        member14.email = "lreedd@xing.com"
        
        let member15 = MemberMO(context: persistentContainer.viewContext)
        member15.name = "Tina Barnes"
        member15.phone = "7-(853)196-4865"
        member15.address = "55481 Hudson Center"
        member15.email = "tbarnese@va.gov"
        
        let member16 = MemberMO(context: persistentContainer.viewContext)
        member16.name = "Christopher Fields"
        member16.phone = "57-(120)966-7695"
        member16.address = "768 Oakridge Road"
        member16.email = "cfieldsf@goodreads.com"
        
        let member17 = MemberMO(context: persistentContainer.viewContext)
        member17.name = "David Howard"
        member17.phone = "994-(647)649-4696"
        member17.address = "19223 Gerald Lane,dhowardg"
        member17.email = "amazon.co.jp"
        
        let member18 = MemberMO(context: persistentContainer.viewContext)
        member18.name = "Eugene Harper"
        member18.phone = "86-(648)742-9185"
        member18.address = "84215 Mcbride Hill"
        member18.email = "eharperh@boston.com"
        
        let member19 = MemberMO(context: persistentContainer.viewContext)
        member19.name = "Louis Dean"
        member19.phone = "46-(182)556-0111"
        member19.address = "6452 Rockefeller Plaza"
        member19.email = "ldeani@toplist.cz"
        
        let member20 = MemberMO(context: persistentContainer.viewContext)
        member20.name = "Ruby Vasquez"
        member20.phone = "63-(612)764-1545"
        member20.address = "3 Mifflin Junction"
        member20.email = "rvasquezj@mysql.com"
        
        saveContext()
        
        UserDefaults.standard.set(true, forKey: "Members")
        
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MyLibrary")
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
    
}

