//
//  WelcomeInteractor.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

class WelcomeInteractor: WelcomeInteractorProtocol {

    // MARK: - Properties
    weak var presenter: WelcomeInteractorOutputProtocol?
    
    // MARK: - Initialization
    init() {
    }
    
    // MARK: - WelcomeInteractorProtocol
    func fetchData() {
        presenter?.didSuccessFetchData()
    }
} 
