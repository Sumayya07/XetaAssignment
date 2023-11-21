//
//  ViewController.swift
//  XetaAssignment
//
//  Created by Sumayya Siddiqui on 21/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var viewSearchExercise: UIView!
    @IBOutlet var recommendedCollectionView: UICollectionView!
    @IBOutlet var categoriesCollectionView: UICollectionView!
    
    var homepageData: Homepage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        fetchHomepageData()
       }
       
    private func setupViews() {
        viewSearchExercise.layer.cornerRadius = viewSearchExercise.frame.size.height / 2
    }
       
    private func setupCollectionView() {
        recommendedCollectionView.delegate = self
        recommendedCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }
    
    func fetchHomepageData() {
        guard let url = URL(string: "http://52.25.229.242:8000/homepage_v2/") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                // Handle any errors appropriately
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle the case where there is no data
                print("No data received")
                return
            }
            
            do {
                // Parse the JSON data
                let decoder = JSONDecoder()
                self.homepageData = try decoder.decode(Homepage.self, from: data)
                
                // Update UI on the main thread
                DispatchQueue.main.async {
                    self.recommendedCollectionView.reloadData()
                    self.categoriesCollectionView.reloadData()
                }
            } catch {
                // Handle any errors during JSON parsing
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }



}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.recommendedCollectionView {
            return 8
        } else if collectionView == self.categoriesCollectionView {
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.recommendedCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedCollectionViewCell", for: indexPath) as! RecommendedCollectionViewCell
          
            return cell
        } else if collectionView == self.categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            
            return cell
        }
        fatalError("Unexpected collection view")
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // Handle selection event
//        if collectionView == self.recommendedCollectionView {
//            // Do something with recommendedItems[indexPath.row]
//        } else if collectionView == self.categoriesCollectionView {
//            // Do something with categories[indexPath.row]
//        }
//    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.recommendedCollectionView {
            return CGSize(width: 377, height: 130)
        } else if collectionView == self.categoriesCollectionView {
            return CGSize(width: 361, height: 366)
        }
        return CGSize.zero // Return zero size for undefined collection views
    }
    
}

