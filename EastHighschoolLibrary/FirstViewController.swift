
import UIKit
import FirebaseDatabase



class FirstViewController: UITableViewController {
    
    var ref: DatabaseReference!
    var count = 0
    var arrayBookNames = UserDefaults.standard.array(forKey: "arrayBookNames")
    var arrayBookStock = UserDefaults.standard.array(forKey: "arrayBookStock")
    var username = UserDefaults.standard.string(forKey: "username")
    @IBOutlet weak var stockLabel: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.arrayBookNames!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.bookImage.image = UIImage(named:"\(arrayBookNames![indexPath.row])")!
        cell.stockLabel?.text = "Stock:\(self.arrayBookStock![indexPath.row])"
        print(cell.bookImage)
        cell.bookNameLabel?.text = "\(arrayBookNames![indexPath.row])"
        return cell
        
        }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
      let row = indexPath.row
        
    UserDefaults.standard.set(row, forKey: "bookNumber")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let checkOutController = storyBoard.instantiateViewController(withIdentifier: "CheckoutController") as! CheckoutController
        self.present(checkOutController, animated:true, completion:nil)
    }
    }




