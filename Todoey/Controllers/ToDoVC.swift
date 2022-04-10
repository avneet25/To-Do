//
//  ViewController.swift
//  Todoey
//
//  Created by Avneet Kaur on 2022-04-04.
//

import UIKit

class ToDoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var todoTableView: UITableView!
    var itemArray = [Item]()
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        designInit()
        loadItems()
        
    }
  
    func designInit()
    {
        todoTableView.rowHeight = 60
        todoTableView.tableFooterView = UIView()
        todoTableView.separatorInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    //MARK: Button actions
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var tempTextFeild = UITextField()
        let newItem = Item()
        
        let alert = UIAlertController.init(title: "Add Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Done", style: .default) { [self] action in
            //what happens when user clicks Done button on UIAlert
            newItem.title = tempTextFeild.text!
            itemArray.append(newItem)
            saveItems()
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
        saveItems()
    }

    // MARK: Model Manipulation Methods
    func saveItems()
    {
        let encoder = PropertyListEncoder() //initialising the encoder
        
        do{
            let data = try encoder.encode(itemArray) //encoding data
            try data.write(to: filePath!) //writing to .plist
        }catch {
            print("Error encoding itemarray, \(error)")
        }
        
        self.todoTableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: filePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
            print("Error decoding item array, \(error)")
                
            }
        }
    }
}



