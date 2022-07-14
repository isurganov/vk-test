//
//  VKCell.swift
//  vk-test
//
//  Created by Иван Трубецкой on 13.07.2022.
//

import UIKit

class VKCell: UITableViewCell {
    
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var appImage: UIImageView!
    
    var link: String = "www.google.com"
    
    func updateCell(app: Services) {
        labelName.text = app.name
        labelInfo.text = app.description
        appImage.load(urlString: app.icon_url)
        link.self = app.link
    }
    
}

extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
