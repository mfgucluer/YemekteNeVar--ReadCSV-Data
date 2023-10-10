import UIKit
import Foundation


var wd = -1 //Weekday helper number
var mn = 4 //Menu number

var days = ["Monday","Tuesday","Wednesday","Thursday","Friday"]


class ViewController: UIViewController {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var food1: UILabel!
    @IBOutlet weak var food2: UILabel!
    @IBOutlet weak var food3: UILabel!
    @IBOutlet weak var food4: UILabel!
    @IBOutlet weak var calorie: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "menu.jpeg")
        mn = fixBug1()
        AllMenuLabel(mn: mn)
    }
    
    
    func fixBug1() -> Int {
        //Bugunun tarihini asagidaki bicimde bulma. Bugun tarihinin kacinci satirda oldugunu bulup AllMenuLabel fonksiyonuna yukarida gonderiyoruz...
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M/yy"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        var count = 0
        
        if let menuEntries = readCSVFile(fileName: "yemekcsv", fileType: "csv") {
            while count < menuEntries.count {
                if menuEntries[count].date == formattedDate {
                    break
                }
                count += 1
            }
        }
        
        print("*****************\(count)****************")
        return count
    }

    func alertFun(title: String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    
    
    func AllMenuLabel(mn: Int){
        
        
        if let menuEntries = readCSVFile(fileName: "yemekcsv", fileType: "csv") {
        
            if(menuEntries[mn].totalCalories != "" ){
            dayLabel.text = changeDate(dateString: menuEntries[mn].date)
            dateLabel.text =  menuEntries[mn].date
            food1.text = menuEntries[mn].soup
            food2.text = menuEntries[mn].mainCourse
            food3.text = menuEntries[mn].sideDish
            food4.text = menuEntries[mn].dessert
            calorie.text = String(menuEntries[mn].totalCalories)}
            else{
                alertFun(title: menuEntries[mn].soup ?? "Yemekhane kapali", message: "Yemekhane Kapali")
            }
        
            
        } else {
            
            print("No menu entries found.")
        }
    }
    
    
    @IBAction func nextClicked(_ sender: Any) {
        
        let menuEntries = readCSVFile(fileName: "yemekcsv", fileType: "csv")
        dateLabel.text =  menuEntries?[mn].date
        
        
        if(menuEntries?.last?.date != dateLabel.text)
        {
        
            if(dayLabel.text != "Friday"){
                mn += 1
                AllMenuLabel(mn: mn)
            }
                else{
                mn += 2
                AllMenuLabel(mn: mn)
            }
                }
        
        }
    
    @IBAction func previousClicked(_ sender: Any) {
        
        let menuEntries = readCSVFile(fileName: "yemekcsv", fileType: "csv")
        
     
        
        if(menuEntries?[mn-1].totalCalories.hasPrefix("Enerji") == false){
        if(dayLabel.text != "Monday"){
            
            mn -= 1
            AllMenuLabel(mn: mn)
        }
            else{
            
                
            mn -= 2
            AllMenuLabel(mn: mn)
        }
            }
    }
    
    
    func changeDate(dateString: String) -> String{
        // DateFormatter ile tarihi Date nesnesine çevirme
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M/yy"
        
        if let date = dateFormatter.date(from: dateString) {
            // Calendar ile gün adını bulma
            let calendar = Calendar.current
            //let dayOfWeek = calendar.component(.weekday, from: date)
            // DateFormatter ile gün adını yazdırma
            let dayNameFormatter = DateFormatter()
            dayNameFormatter.dateFormat = "EEEE"
            let dayName = dayNameFormatter.string(from: date)
            
            return dayName
            
            //print("\(dateString) tarihi \(dayName) günüdür. (Haftanın \(dayOfWeek). günü)")
        } else {
             return "Geçersiz tarih formatı"
        }
        
        
    }
    
    

}


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
            let rows = data.components(separatedBy: "\n") //TrExplanation for me: Components burada bir stringi ayirip diziye atiyor.
            for row in rows {
                let columns = row.components(separatedBy: ";")// Buda ayni sekilde...
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
