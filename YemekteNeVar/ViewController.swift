import UIKit

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
        dateLabel.text = "9/10/2023"
        food1.text = "Ezogelin Corba 170 kkcal"
        food2.text = "Kuru Fasulye 250kkcal"
        food3.text = "Pirinc Pilavi 300 kkcal "
        food4.text = "Trilece 400 kkcal"
        calorie.text = "1120 kkcal"
    }


}

