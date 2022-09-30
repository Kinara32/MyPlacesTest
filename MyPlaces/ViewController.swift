//
//  ViewController.swift
//  MyPlaces
//
//  Created by Matvei Bykadorov on 29.09.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let restraurantNames = [
    "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
    "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
    "Speak Easy", "Morris Pub", "Вкусные истории",
    "Классик", "Love&Life", "Шок", "Бочка"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restraurantNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
//        var contentCell = cell.defaultContentConfiguration()
//        contentCell.text = restraurantNames[indexPath.row]
//        contentCell.image = UIImage(named: restraurantNames[indexPath.row])
//        contentCell.imageProperties.cornerRadius = cell.frame.size.height / 2
//        cell.contentConfiguration = contentCell
        
        cell.nameLabel?.text = restraurantNames[indexPath.row]
        cell.imageOfPlace?.image = UIImage(named: restraurantNames[indexPath.row])
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }

    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

