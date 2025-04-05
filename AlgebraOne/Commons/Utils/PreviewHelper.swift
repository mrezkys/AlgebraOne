//
//  PreviewHelper.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import SwiftUI

#if DEBUG
// Helper struct for UIKit previews in SwiftUI
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewControllerBuilder: () -> ViewController
    
    init(_ viewControllerBuilder: @escaping () -> ViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        return viewControllerBuilder()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}
#endif 
