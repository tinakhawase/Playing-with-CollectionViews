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
    
    
    private var photosFromApi: Welcome
    
    
    required init?(coder aDecoder: NSCoder) {
        self.photosFromApi = Welcome(page : 0, perPage: 0,photos : [], nextPage : "", prevPage: "")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.viewcontroller.dataSource = self as? UICollectionViewDataSource
        self.viewcontroller.delegate = self as? UICollectionViewDelegate
        
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
                
                DispatchQueue.main.async { [weak self] in
                    self?.photosFromApi = serverResponse as Welcome
                    self?.viewcontroller.reloadData()
                }
            } else {
                print("Oh noes! error!")
            }
            
        }
        
        task.resume()
    }
    
}
    extension ViewController: UICollectionViewDelegate {
        
    }
    
    extension ViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return self.photosFromApi.photos.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let photocell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            let myphotos = photosFromApi.photos[indexPath.row]
            //something that will give access to photographerurl
            //internal var picphoto: Welcome.Photo?
            //img.image = picphoto?.UIImage(named: "photographerURL")
            
            return photocell
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

