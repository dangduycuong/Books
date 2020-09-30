//
//  ViewController.swift
//  Books
//
//  Created by Dang Duy Cuong on 9/30/20.
//  Copyright © 2020 Dang Duy Cuong. All rights reserved.
//

import UIKit

class TotalData {
    var data: Covid19Model?
    var image: UIImage?
}

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var listImage = [UIImage]()
    var countryNames: [Covid19Model] = []
    var suggestCountryNames: [Covid19Model] = []
    var totalData = [TotalData]()
    var suggestdata = [TotalData]()
    var dataCountry = TotalData()
    var indexToTal = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShadowView()
        searchTextField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromAPI(completedHandle: { data in
            self.countryNames = data
            self.suggestCountryNames = data
        
            repeat {
                if let url = self.countryNames[indexToTal].countryInfo?.flag {
                    
                    self.dataCountry.data = self.countryNames[indexToTal]
                    self.totalData.append(self.dataCountry)
                    self.loadImage(url: url)
                }
                self.indexToTal += 1
            } while self.indexToTal < self.countryNames.count
//            self.tableView.reloadData()
        })
        
        tableView.register(CountyCell.nib(), forCellReuseIdentifier: CountyCell.identifier())
    }
    
    func getDataFromAPI(completedHandle: @escaping([Covid19Model]) -> Void) {
        print(CovidAPI.address)
        guard let url = URL(string: CovidAPI.address) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            do {
                let usersData = try JSONDecoder().decode([Covid19Model].self, from: data!)
                DispatchQueue.main.async {
                    completedHandle(usersData.self)
//                    for item in usersData {
//                        if let url = item.countryInfo?.flag {
//                            self.loadImage(url: url)
//                        }
//                    }
                }
            } catch let error {
                print("error", error)
            }
        })
        downloadTask.resume()
    }

    var isDone: Bool = false
    func loadImage(url: String) {
        guard let flagURL = URL(string: url) else {
            return
        }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: flagURL) else {
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.dataCountry.image = image
                    self.totalData.append(self.dataCountry)
                }
            }
        }
    }
    
    func setShadowView() {
        searchView.layer.cornerRadius = 16
        searchView.layer.shadowColor = UIColor.black.cgColor
        searchView.layer.shadowOpacity = 0.8
        searchView.layer.shadowOffset = .zero
        searchView.layer.shadowRadius = 10
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountyCell.identifier(), for: indexPath) as! CountyCell
        cell.countryLabel.text = suggestdata[indexPath.row].data?.country
        cell.flagImageView.image = suggestdata[indexPath.row].image
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "CountryViewController") as! CountryViewController
        vc.title = suggestdata[indexPath.row].data?.country
        if let data = suggestdata[indexPath.row].data {
        vc.infoCountry = data
        }
        title = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func filterCountry() {
        if searchTextField.text == "" {
            suggestdata = totalData
        } else {
            suggestdata = totalData.filter { (data: TotalData) in
                if let text = searchTextField.text, let country = data.data?.country {
                    if country.lowercased().range(of: text.lowercased()) != nil {
                        return true
                    }
                }
                return false
            }
        }
        tableView.reloadData()
    }
    //MARK: Action
    func textFieldDidBeginEditing(_ textField: UITextField) {
        filterCountry()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        filterCountry()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
    }
}
