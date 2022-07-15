//
//  NetworkService.swift
//  vk-test
//
//  Created by Иван Сурганов on 13.07.2022.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
    
    func getData(onSuccess: @escaping (Apps) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let servs = try JSONDecoder().decode(Apps.self, from: data)
                onSuccess(servs)
            } catch {
                print(error)
            }
        }.resume()
    }
}
