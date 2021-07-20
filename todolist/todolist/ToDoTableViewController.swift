//
//  ToDoTableViewController.swift
//  todolist
//
//  Created by chai_goldpig on 7/19/21.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    var listOfToDo : [ToDoCD] = []
    //var listOfToDo : [ToDoClass] = []
    
    /* func createToDo() -> [ToDoClass] {
        let codeGoal = ToDoClass()
        codeGoal.description = "extend knowledge in known coding languages"
        
        let musicToDo = ToDoClass()
        musicToDo.description = "pick up violin bow"
        musicToDo.important = true
        
        return [codeGoal, musicToDo]
    }
 */
    func getToDos(){
        if let accessToCoreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let dataFromCoreData = try?
                accessToCoreData.fetch(ToDoCD.fetchRequest()) as? [ToDoCD]{
                
                listOfToDo = dataFromCoreData
                tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //listOfToDo = createToDo()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listOfToDo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let eachToDo = listOfToDo[indexPath.row]
        cell.textLabel?.text = eachToDo.description
        
        if let thereIsDescription = eachToDo.descriptionInCD {
            if eachToDo.importantInCD {
                cell.textLabel?.text = "❗️" + thereIsDescription
            } else {
                cell.textLabel?.text = eachToDo.descriptionInCD
            }
        }
        /* if eachToDo.important {
            cell.textLabel?.text = "❗️" + eachToDo.description
        }else{
            cell.textLabel?.text = eachToDo.description
        }
 */
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let eachToDo = listOfToDo[indexPath.row]
        
        performSegue(withIdentifier: "moveToCompletedToDoVC", sender: eachToDo)
    }

    override func viewWillAppear(_ animated: Bool){
        getToDos()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextAddToDoVC = segue.destination as? AddToDoViewController {
            
            nextAddToDoVC.previousToDoTVC = self
        }
        
        if let nextCompletedToDoVC = segue.destination as? CompletedToDoViewController {
            
            if let chosenToDo = sender as? ToDoCD {
            //if let chosenToDo = sender as? ToDoClass {
                
                nextCompletedToDoVC.selectedToDo = chosenToDo
                nextCompletedToDoVC.previousToDoTVC = self
                
            }
        }
    }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
   

}
