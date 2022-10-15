//
//  ViewController.swift
//  RelaxCafe
//
//  Created by kuani on 2022/9/27.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var storeInfo = [CoffeeStoreInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func searchResult(city:String){
        if let urlString = "https://cafenomad.tw/api/v1.2/cafes/\(city)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString){
               URLSession.shared.dataTask(with: url) { data, response, error in
                   if let data{
                       let decoder = JSONDecoder()
                       do{
                           let result = try decoder.decode([CoffeeStoreInfo].self, from: data)
                           self.storeInfo = result
                           
                           DispatchQueue.main.async {
                               self.tableView.reloadData()
                           }
                       }
                       catch{
                           print(error)
                       }
                   }
               }.resume()
           }
      }
   
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(StoreNameTableViewCell.self)", for: indexPath) as! StoreNameTableViewCell
        let item = storeInfo[indexPath.row]
        cell.storeNameLabel.text = item.name
        
        return cell
    }
   /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            if let indexpath = tableView.indexPathForSelectedRow{
                let controller = segue.destination as! DetailViewController
                controller.storeInfo = storeInfo[indexpath.row]
            }
        }
    }
}
extension ViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResult(city: searchBar.text ?? "")
        view.endEditing(true)
    }
    
}
