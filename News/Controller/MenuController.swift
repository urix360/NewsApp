//
//  MenuController.swift
//  News
//
//  Created by Uri Vishnevski on 27/09/2020.
//  Copyright © 2020 Uri Vishnevski. All rights reserved.
//
import UIKit
import SideMenu
import Foundation

protocol MenuControllerDelegate {
    func didSelectCategory(category : String)
}

class MenuController: UITableViewController {
    private var Titles : [String]
    public var delegate : MenuControllerDelegate?
    init(array : [String]) {
        Titles = array
        super.init(nibName: nil,bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        tableView.separatorStyle = .none
        view.backgroundColor = .darkGray
    }
    
    //TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       Titles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = Titles[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        delegate?.didSelectCategory(category: cell?.textLabel?.text ?? "")
        
    }
}
