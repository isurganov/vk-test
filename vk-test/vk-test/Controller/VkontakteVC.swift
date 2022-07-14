//
//  ViewController.swift
//  vk-test
//
//  Created by Иван Трубецкой on 13.07.2022.
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
            debugPrint(services.body.services.count)
            let fitems = services.body.services
            debugPrint(fitems.count)
            self.items = fitems
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
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: items[indexPath.row].link)!
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

