//
//  ViewController.swift
//  realmToDo
//
//  Created by 伊藤明孝 on 2021/05/08.
//

import UIKit
import Realm
import RealmSwift


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var todoItems: Results<ToDo>!
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        
        let realm = try! Realm()
        todoItems = realm.objects(ToDo.self)
        
        table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let object = todoItems[indexPath.row]
        cell.textLabel?.text = object.title
        return cell
    }
    
    
    //スワイプアクションによる削除
    //スワイプによって呼び出されるデリゲートメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteTodo(at: indexPath.row)
            table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toAdd", sender: indexPath.row)
    }
    
    //
    func deleteTodo(at index: Int) {
        let realm = try! Realm()
        try! realm.write{
            realm.delete(todoItems[index])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        if segue.identifier == "toAdd"{
            let viewController = segue.destination as! addViewController
            viewController.selectedIndex = sender as? Int
        }
    }
    
    @IBAction func tappedAddButton(){
        performSegue(withIdentifier: "toAdd", sender: nil)
    }


}

