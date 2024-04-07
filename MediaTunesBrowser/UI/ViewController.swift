//
//  ViewController.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 06.04.2024.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var networkService: NetworkService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(self.label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkService.send(
            request: .search(
                searchParameters: [
                    "term": "jack jonson",
                    "limit": 25
            ]
            )
        ) { [weak self] (result: NetworkResult<(SearchResponseModel)>) in
            switch result {
            case .success(let response):
                print("total count: \(response.resultCount)")
                print("items: \(response.results)")
            case .failure(let networkError):
                print(networkError)
            }
        }
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello World!"
        label.textColor = UIColor.white
        return label
    }()
}

struct VCNetworkConfiguration: NetworkConfiguration {
    var apiRoot: URL { URL(string: "https://itunes.apple.com")! }
}

