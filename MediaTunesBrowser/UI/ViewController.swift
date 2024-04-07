//
//  ViewController.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 06.04.2024.
//

import UIKit
import Foundation

class ViewController: LoadingContentViewController {

    var networkService: NetworkService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(button)
        button.centerInSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private lazy var button = UIButton().then {
        $0.setTitle("load data", for: .normal)
        $0.addTarget(self, action: #selector(onButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onButton(_ sender: UIButton) {
        sender.isEnabled = false
        startAnimating()
        networkService.send(
            request: .search(
                searchParameters: [
                    "term": "jack jonson",
                    "limit": 300
            ]
            )
        ) { [weak self] (result: NetworkResult<(SearchResponseModel)>) in
            defer { 
                sender.isEnabled = true
                self?.stopAnimating()
            }
            switch result {
            case .success(let response):
                print("total count: \(response.resultCount)")
                print("items: \(response.results)")
            case .failure(let networkError):
                print(networkError)
            }
        }
    }
}

struct VCNetworkConfiguration: NetworkConfiguration {
    var apiRoot: URL { URL(string: "https://itunes.apple.com")! }
}

