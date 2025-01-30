//
//  HomeViewController.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()              
        // Do any additional setup after loading the view.        
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
