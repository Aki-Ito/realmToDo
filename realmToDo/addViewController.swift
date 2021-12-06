//
//  addViewController.swift
//  realmToDo
//
//  Created by 伊藤明孝 on 2021/05/09.
//

import UIKit
import Realm
import RealmSwift

class addViewController: UIViewController, UITextFieldDelegate {
    
    var selectedIndex: Int?
    var todoItems: Results<ToDo>!
    
    @IBOutlet weak var textBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textBox.delegate = self
        
        
        let realm = try! Realm()
        todoItems = realm.objects(ToDo.self)
        
        if selectedIndex != nil{
            textBox.text = todoItems[selectedIndex!].title
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addbtn(_ sender: Any) {
        
        let realm = try! Realm()
        
        if selectedIndex != nil{
            
            let storedTitle = realm.objects(ToDo.self)[selectedIndex!]
            
            try! realm.write{
                storedTitle.title = textBox.text!
            }
        }else{
            
            let todo = ToDo()
            
            todo.title = textBox.text!
            
            try! realm.write{
                realm.add(todo)
            }
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textBox.resignFirstResponder()
        return true
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
