//
//  PaginationHandler.swift
//  SamplePaginationApplication
//
//  Created by Rubha Selvaraj on 30/05/24.
//

import Foundation

final class PaginationHandler {
    
    private let viewModel = ViewModel()

    private var currentPage = 0
    private var totalPages = 0
    private let limit = 30
    private var isFetching = false

    func fetchUserInfo(completion: @escaping (([UserInfo]?) -> Void)) {
        if !isFetching {
            incrementPage()
            viewModel.loadData(for: currentPage) { [weak self] userInfo in
                self?.isFetching = false
                if userInfo == nil || userInfo?.count == 0 {
                    self?.decrementPage()
                    completion(nil)
                } else {
                    completion(userInfo)
                }
            }
        }
    }
        
    func getCurrentPage() -> Int {
        currentPage
    }
}

private extension PaginationHandler {
    
    func incrementPage() {
        currentPage += 1
        totalPages += 1
    }
    
    func decrementPage() {
        currentPage -= 1
        totalPages -= 1
    }
}
