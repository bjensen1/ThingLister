//
//  ViewController.swift
//  ThingLister
//
//  Created by Brent Jensen on 6/24/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var things: [Thing] = ModelService.shared.getAllThings()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThingCell") as! ThingCell
        
        if let thing = thingForIndexPath(indexPath) {
            cell.imageView?.image = thing.image
            cell.title.text = thing.name
        }
        
        return cell
    }
    
    private func thingForIndexPath(_ indexPath: IndexPath) -> Thing? {
        guard indexPath.row < things.count else { return nil }
        
        return things[indexPath.row]
    }
    
    @IBAction func addButtonPressed() {
        let alert = UIAlertController(title: "What sort of thing would you like to add?", message: "", preferredStyle: .actionSheet)
        
        func handler(action:UIAlertAction) {
            performSegue(withIdentifier: action.title!, sender: nil)
        }
        
        alert.addAction(UIAlertAction(title: "Animal", style: .default, handler:handler))
        alert.addAction(UIAlertAction(title: "Book", style: .default, handler:handler))
        alert.addAction(UIAlertAction(title: "Car", style: .default, handler:handler))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController,
           let addThingsController = navController.viewControllers.first as? AddThingViewController {
            addThingsController.thing = sender as? Thing
            
            addThingsController.saveAction = {
                [unowned self] in
                self.tableView.reloadData()
                self.dismiss(animated: true, completion: nil)
            }
            addThingsController.cancelAction = {
                [unowned self] in
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

