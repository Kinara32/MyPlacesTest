//
//  ViewController.swift
//  MyPlaces
//
//  Created by Matvei Bykadorov on 29.09.2022.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewPlaces: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var reversedSortingButton: UIBarButtonItem!
    
    var places: Results<Place>!
    var ascendingSorting = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        
//        var contentCell = cell.defaultContentConfiguration()
//        contentCell.text = restraurantNames[indexPath.row]
//        contentCell.image = UIImage(named: restraurantNames[indexPath.row])
//        contentCell.imageProperties.cornerRadius = cell.frame.size.height / 2
//        cell.contentConfiguration = contentCell
        
        cell.nameLabel?.text = places[indexPath.row].name
        cell.locationLabel.text = places[indexPath.row].location
        cell.typeLabel.text = places[indexPath.row].type
        cell.imageOfPlace.image = UIImage(data: places[indexPath.row].imageData!)
        
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let place = places[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            StorageManager.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableViewPlaces.indexPathForSelectedRow else {return}
            let newPlaceVC = segue.destination as! NewPlaceTableViewController
            newPlaceVC.currentPlace = places[indexPath.row]
        }
    }
    
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        
        guard let newPlaceVC = segue.source as? NewPlaceTableViewController else {return}
        
        newPlaceVC.savePlace()
        tableViewPlaces.reloadData()
    }
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        sorting()
    }
    
    @IBAction func reversedSorting(_ sender: UIBarButtonItem) {
        ascendingSorting.toggle()
        sorting()
        
    }
    private func sorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            places = places.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        tableViewPlaces.reloadData()
    }
}

