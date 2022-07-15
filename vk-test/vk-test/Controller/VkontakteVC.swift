//
//  ViewController.swift
//  vk-test
//
//  Created by Иван Сурганов on 13.07.2022.
//

import UIKit
import SafariServices

class VkontakteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemsTable: UITableView!
    
    var items = Array<Services>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTable.backgroundColor = .black
        itemsTable.delegate = self
        itemsTable.dataSource = self
        getData()
    }
    
    func getData() {
        NetworkService.shared.getData { (services) in
            self.items = services.body.services
            DispatchQueue.main.async {
                self.itemsTable.reloadData()
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VKCell") as? VKCell {
            cell.updateCell(app: items[indexPath.row])
            cell.backgroundColor = .black
            cell.labelInfo.adjustsFontSizeToFitWidth = true
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let application = UIApplication.shared
        if let url = URL(string: "\(items[indexPath.row].name)://"), application.canOpenURL(url) {
            application.open(url, options: [:], completionHandler: nil)
        } else if let itunesUrl = URL(string: items[indexPath.row].link), application.canOpenURL(itunesUrl) {
            let vc = SFSafariViewController(url: URL(string: items[indexPath.row].link)!)
            present(vc, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

