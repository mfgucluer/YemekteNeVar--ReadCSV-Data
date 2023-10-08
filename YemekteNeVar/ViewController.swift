import UIKit
import Foundation

struct MenuEntry {
    var date: String
    var soup: String
    var mainCourse: String
    var sideDish: String
    var dessert: String
    var totalCalories: String
}

func readCSVFile(fileName: String, fileType: String) -> [MenuEntry]? {
    var menuEntries = [MenuEntry]()
    if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileType) {
        do {
            let data = try String(contentsOf: fileURL, encoding: .utf8)
            let rows = data.components(separatedBy: "\n")
            for row in rows {
                let columns = row.components(separatedBy: ";")
                if columns.count >= 6 {
                    let date = columns[0]
                    let soup = columns[1]
                    let mainCourse = columns[2]
                    let sideDish = columns[3]
                    let dessert = columns[4]
                    let totalCalories = columns[5]
                    
                    let menuEntry = MenuEntry(date: date, soup: soup, mainCourse: mainCourse, sideDish: sideDish, dessert: dessert, totalCalories: totalCalories)
                    menuEntries.append(menuEntry)
                }
            }
        } catch {
            print("Error reading file: \(error)")
        }
    } else {
        print("File not found.")
    }
    
    return menuEntries.isEmpty ? nil : menuEntries
}


class ViewController: UIViewController {
    

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var food1: UILabel!
    @IBOutlet weak var food2: UILabel!
    @IBOutlet weak var food3: UILabel!
    @IBOutlet weak var food4: UILabel!
    @IBOutlet weak var calorie: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "menu.jpeg")
//        dateLabel.text = "9/10/2023"
//        food1.text = "Ezogelin Corba 170 kkcal"
//        food2.text = "Kuru Fasulye 250kkcal"
//        food3.text = "Pirinc Pilavi 300 kkcal "
//        food4.text = "Trilece 400 kkcal"
//        calorie.text = "1120"
        
        if let menuEntries = readCSVFile(fileName: "yemekcsv", fileType: "csv") {
            
            dateLabel.text =  menuEntries[5].date
            food1.text = menuEntries[5].soup
            food2.text = menuEntries[5].mainCourse
            food3.text = menuEntries[5].sideDish
            food4.text = menuEntries[5].dessert
            calorie.text = String(menuEntries[5].totalCalories)
            

//            for entry in menuEntries {
//
//                print("Date: \(entry.date)")
//                print("Soup: \(entry.soup)")
//                print("Main Course: \(entry.mainCourse)")
//                print("Side Dish: \(entry.sideDish)")
//                print("Dessert: \(entry.dessert)")
//                print("Total Calories: \(entry.totalCalories)")
//                print("-----")
//            }
        } else {
            print("No menu entries found.")
        }
        
    }
    
}
