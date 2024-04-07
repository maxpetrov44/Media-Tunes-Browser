//
//  LoadingContentViewController.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import UIKit

class LoadingContentViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loader)
        loader.centerInSuperview()
    }
    
    private let loader = UIActivityIndicatorView(style: .medium).then {
        $0.hidesWhenStopped = true
        $0.tintColor = .white
    }
    
    func startAnimating() {
        view.bringSubviewToFront(loader)
        loader.isHidden = false
        loader.startAnimating()
    }
    
    func stopAnimating() {
        loader.stopAnimating()
        
    }
}
