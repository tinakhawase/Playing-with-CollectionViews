//
//  ViewController.swift
//  LoadImagesFromApi
//
//  Created by Deepashri Khawase on 26.04.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var viewcontroller: UICollectionView!
    
    // This var is used to store the information from network call
    private var photosFromApi: Welcome
    
    // Tip: If you want to init a ViewController, use this init(coder aDecoder: NSCoder) type init
    required init?(coder aDecoder: NSCoder) {
        self.photosFromApi = Welcome(page : 0, perPage: 0,photos : [], nextPage : "", prevPage: "")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tell the tableView that this `self` is the datasource and delegate of it
        self.viewcontroller.dataSource = self as? UICollectionViewDataSource
        self.viewcontroller.delegate = self as? UICollectionViewDelegate
        // Homework: Add a closure/lambda to this method as a parameter
        // and do the tableView operations there.
        getSubjects()
    }

    
    func getSubjects() {
        
        let apiUrl = "https://api.pexels.com/v1/curated?per_page=15&page=2"
        
        guard let baseUrl = URL(string: apiUrl)
            else { return }
        
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "GET"
        request.addValue("563492ad6f91700001000001e80b0a30b96b4593966d38568a5fbb80", forHTTPHeaderField: "Authorization")
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let serverResponse = try? decoder.decode(Welcome.self, from: data),
                let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                // save the serverResponse in self member subjectFromApi
                // reload the tableView
                DispatchQueue.main.async { [weak self] in
                    self?.photosFromApi = serverResponse as Welcome
                    self?.viewcontroller.reloadData()
                }
            } else {
                print("Oh noes! error!")
            }
            /* This code block is for diagnostic purposes, to print the json received
             guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
             print("Not containing JSON")
             return
             }
             print(json)
             */
        }
        
        task.resume()
    }
    
}
    extension ViewController: UICollectionViewDelegate {
        
    }
    
    extension ViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // count of the works from the subjects we received
            return self.photosFromApi.photos.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            // Create a `reusable` tableViewCell for the index no denoted by indexPath param.
            // How to get the `reusable`cell? Just ask the TableView!
            let photocell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            let myphotos = photosFromApi.photos[indexPath.row]
            //something that will give access to photographerurl
            //internal var picphoto: Welcome.Photo?
            //img.image = picphoto?.UIImage(named: "photographerURL")
            
            return photocell
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

