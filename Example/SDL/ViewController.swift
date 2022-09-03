//
//  ViewController.swift
//  SDL
//
//  Created by MrTrent on 09/03/2022.
//  Copyright (c) 2022 MrTrent. All rights reserved.
//

import UIKit
import SDL

struct SomeData {
    var name: String
    var age: Int
}

class ViewController: UIViewController {

    var data: SomeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configure()
    }
    
    func configure() {
        view.backgroundColor = .white
        
        // button to test
        let btn = UIButton.init(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        
        if let _ = data {
            btn.backgroundColor = .green
            btn.setTitle("Data transfered.", for: .normal)
        } else {
            btn.backgroundColor = .red
            btn.setTitle("No Data - tap me!", for: .normal)
            btn.addTarget(self, action: #selector(exampleSegue), for: .touchUpInside)
        }
        
        view.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btn.widthAnchor.constraint(equalTo: view.widthAnchor),
            btn.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc
    func exampleSegue() {
        // create example data
        let data = SomeData(name: "Noname", age: 0)
        // wrap data to some string key
        let key = SDL.shared.set(data)
        // as example you can use it as url query item
        if let url = URL(string: "/vc2?data=\(key)") {
            goTo(url)
        }
    }
    
    func goTo(_ url: URL) {
        // try get data from url query key
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let item = components.queryItems?.first(where: {$0.name == "data"}),
              let key = item.value,
              let data = SDL.shared.get(for: key, expectedType: SomeData.self)
        else {
            // show some error
            print("Data not found...")
            return
        }
        
        // create controller, set data and push - imitation of router
        print("Data transfered...")
        let vc = ViewController()
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

