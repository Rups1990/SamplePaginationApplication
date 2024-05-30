//
//  ViewModel.swift
//  SamplePaginationApplication
//
//  Created by Rubha Selvaraj on 29/05/24.
//

import Foundation

struct ViewModel {
        
    func loadData(for pageNumber: Int, 
                  with limit: Int = 30,
                  completion: @escaping (([UserInfo]?) -> Void)) {
        
        let urlString = "https://jsonplaceholder.typicode.com/posts?_page=\(pageNumber)&_limit=\(limit)"
        guard let url = URL(string: urlString) else {
           completion(nil)
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){data, _, error in
            if error != nil { return completion(nil) }
            guard let data = data else { return completion(nil)  }
            do {
                let contents = try JSONDecoder().decode([UserInfo].self, from: data)
                completion(contents)
            } catch {
                completion(nil)
                return
            }
        }
        task.resume()
    }
        
}
