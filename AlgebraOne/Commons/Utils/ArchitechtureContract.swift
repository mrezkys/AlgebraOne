//
//  ArchitechtureContract.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit

// MARK: - Base Protocols
// These are the base protocols that all module-specific protocols will inherit from

// MARK: - Base View Protocol
protocol ViewProtocol: AnyObject {
}

// MARK: - Base Presenter Protocol
protocol PresenterProtocol: AnyObject {
}

// MARK: - Base Interactor Protocol
protocol InteractorProtocol: AnyObject {
}

// MARK: - Base Interactor Output Protocol
protocol InteractorOutputProtocol: AnyObject {
}

// MARK: - Base Router Protocol
protocol RouterProtocol: AnyObject {
}
