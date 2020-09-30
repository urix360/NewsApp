//
//  ViewController.swift
//  News
//
//  Created by Uri Vishnevski on 27/09/2020.
//  Copyright © 2020 Uri Vishnevski. All rights reserved.
//

import UIKit
import SideMenu
import SafariServices

class ViewController: UITableViewController,  MenuControllerDelegate {
    
    private var sideMenu : SideMenuNavigationController!
    private let menu = MenuController(array: ["business", "entertainment",
                                              "general", "health", "science",
                                              "sports", "technology"])
    private var articles : [article]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "articleCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 120
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        self.didSelectCategory(category: "business")
        
    }
    @IBAction func tapMenu(_ sender: UIBarButtonItem) {
        present(sideMenu, animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! articleCell
        cell.cellLabel.font = .boldSystemFont(ofSize: 20)
        cell.cellLabel.text = articles?[indexPath.row].title
        cell.cellImage.image = donloadImage(from: articles![indexPath.row].imageUrl)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = articles![indexPath.row].webUrl
        if let url = URL(string: urlString){
            let safariVC = SFSafariViewController(url: url)
            present(safariVC,animated: true)
        }
    }
    
    func didSelectCategory(category: String) {
        let url = "https://newsapi.org/v2/top-headlines?country=il&category=" + category + "&apiKey=fdd20a2cc99c449c96a46e539ab9dea7"
        performRequest(with: url)
        navigationItem.title = category
        sideMenu.dismiss(animated: true, completion: nil)
    }
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("error")
                    return
                }
                if let safeData = data {
                    if let article = self.parseJSON(safeData){
                        self.articles = article.articles
                        DispatchQueue.main.async{
                        self.tableView.reloadData()
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ newsData: Data) -> news? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(news.self, from: newsData)
            return decodedData
            
        } catch {
            print(error)
            return nil
        }
        
    }
    
    func donloadImage(from: String) -> UIImage?{
        if let url = URL(string: from){
            do {
                let data = try Data(contentsOf: url)
                return UIImage(data: data)
            }
            catch{
                print(error)
            }
        }
        return UIImage.init()
    }
    
}

