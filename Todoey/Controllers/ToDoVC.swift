//
//  ViewController.swift
//  Todoey
//
//  Created by Avneet Kaur on 2022-04-04.
//

import UIKit

class ToDoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var todoTableView: UITableView!
    var itemArray = [Item()]
    let defaults = UserDefaults.standard
    let KEY = "ToDoKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = Item()
        let newItem2 = Item()
        newItem.title = "Todo"
        newItem2.title = "CoreData"
        itemArray.append(newItem)
        itemArray.append(newItem2)
        
        if let items = defaults.array(forKey: KEY) as? [Item]
        {
            itemArray = items
            print(itemArray)
        }
        
    }
  
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var tempTextFeild = UITextField()
        let newItem = Item()
        
        let alert = UIAlertController.init(title: "Add Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Done", style: .default) { [self] action in
            //what happens when user clicks Done button on UIAlert
            newItem.title = tempTextFeild.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: KEY)
            self.todoTableView.reloadData()
        }
        
        alert.addTextField { alertTextFeild in
            alertTextFeild.placeholder = "Enter New Item"
            tempTextFeild = alertTextFeild
        }
        
        alert.addAction(action)
        present(alert, animated: true) {
            
        }
    }
    
    
    // MARK: Tableview data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TableViewCell
      
        let item = itemArray[indexPath.row]
        cell.todoLbl.text = item.title
        
//        value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
       
        
        return cell
    }

    // MARK: Tableview Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        todoTableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        todoTableView.reloadData()
    }

}

