//
//  FestivosTableViewController.swift
//  MemoryTool
//
//  Created by Mac4 on 31/01/21.
//

import UIKit

class FestivosTableViewController: UITableViewController{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var listOfHolidays = [HolidayDetail](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfHolidays.count) dias festivos encontrados"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfHolidays.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let festivo = tableView.dequeueReusableCell(withIdentifier: "festivo", for: indexPath)
        
        let holiday = listOfHolidays[indexPath.row]
        
        festivo.textLabel?.text = holiday.name
        festivo.detailTextLabel?.text = holiday.date.iso
        
        return festivo
    }
    
    
}

extension FestivosTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let holidayRequest = FestivoRequest(countryCode: searchBarText)
        holidayRequest.getHolidays {[weak self] result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let holidays):
                self?.listOfHolidays = holidays
            }
        }
    }
    
}
