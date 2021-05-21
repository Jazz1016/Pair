//
//  PairListViewController.swift
//  PairAssesment
//
//  Created by James Lea on 5/21/21.
//

import UIKit

class PairListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var pairListTableView: UITableView!
    
    

    // MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        pairListTableView.delegate = self
        pairListTableView.dataSource = self
        
        PersonController.shared.loadFromPersistentStore()
    }
    
    // MARK: - Actions
    
    @IBAction func addNewPersonButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add", message: "Add a new person", preferredStyle: .alert)
        
        alertController.addTextField { textfield in
            textfield.placeholder = "enter name..."
        }
        
        let addPersonAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let name = alertController.textFields?[0].text, !name.isEmpty else {return}
            
            PersonController.shared.addPerson(name: name)
            self.pairListTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addPersonAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
        self.pairListTableView.reloadData()
    }
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
        
        PersonController.shared.randomizeGroups()
        self.pairListTableView.reloadData()
        
    }
    

}


extension PairListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return PersonController.shared.groups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.groups[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        cell.textLabel?.text = PersonController.shared.groups[indexPath.section][indexPath.row].name
        
        return cell
    }
    
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = PersonController.shared.groups[indexPath.section][indexPath.row]
            
            PersonController.shared.deletePerson(person: person)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
