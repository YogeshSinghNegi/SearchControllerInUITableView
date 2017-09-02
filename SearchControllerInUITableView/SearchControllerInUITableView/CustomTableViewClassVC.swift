//
//  CustomTableViewClassVC.swift
//  SearchControllerInUITableView
//
//  Created by yogesh singh negi on 30/08/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

//=============================================================//
//MARK: CustomTableViewClassVC Class
//=============================================================//

class CustomTableViewClassVC: UIViewController {
    
//=============================================================//
//MARK: Stored Property
//=============================================================//
    
    let s1Data: [String] = ["yogesh","Row 11", "Row 12", "Row 13","Row 14", "Row 15", "Row 16"]
    let s2Data: [String] = ["yogi","negi","Row 21", "Row 22", "Row 23"]
    let s3Data: [String] = ["yuvraj","singh","Row 31", "Row 32", "Row 33","Row 34", "Row 35"]
    
    var sectionData: [Int: [String]] = [:]
    var filteredArray = [String]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
//=============================================================//
//MARK: Defining IBOutlet for UITableView
//=============================================================//
    
    @IBOutlet weak var customTableView: UITableView!
   
//=============================================================//
//MARK: View Methods
//=============================================================//
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.customTableView.delegate = self
        self.customTableView.dataSource = self
        self.navigationItem.title = "Learning Sections"
        sectionData = [0:s1Data, 1:s2Data, 2:s3Data]
        
        filteredArray = s1Data
        filteredArray = filteredArray + s2Data
        filteredArray = filteredArray + s3Data
        
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.customTableView.tableHeaderView = searchController.searchBar
    }

}

//=================================================================//
//MARK: CustomTableViewClassVC Class Extension for UISearchController
//=================================================================//


extension CustomTableViewClassVC: UISearchResultsUpdating {
    
//=================================================================//
//MARK: Filtering data according to the text entered in the Search Bar
//=================================================================//
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredArray = self.s1Data.filter { team in
                return team.lowercased().contains(searchText.lowercased())
            }
            filteredArray = filteredArray + self.s2Data.filter { team in
            return team.lowercased().contains(searchText.lowercased())
        }
            filteredArray = filteredArray + self.s3Data.filter { team in
                return team.lowercased().contains(searchText.lowercased())
            }
        }
        else {
            filteredArray = self.s1Data + self.s2Data + self.s3Data
        }
        customTableView.reloadData()
    }

}

//=============================================================//
//MARK: CustomTableViewClassVC Class Extension for UITableView
//=============================================================//

extension CustomTableViewClassVC: UITableViewDelegate,UITableViewDataSource{
    
//=============================================================//
//MARK: Setting Number Of Cells
//=============================================================//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredArray.count
    }

    
//=============================================================//
//MARK: Setting the Cell
//=============================================================//
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellForRowClass_ID") as? CellForRowClass else { fatalError("Cell Failed to load") }
        
        cell.nameLabel.text = filteredArray[indexPath.row]
        
        return cell
    }

    
//=============================================================//
//MARK: Setting Height Of the Cell
//=============================================================//
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }

}

//=============================================================//
//MARK: Class for Cell UIViews
//=============================================================//

class CellForRowClass: UITableViewCell{
    
//=============================================================//
//MARK: TableView IBOutlets
//=============================================================//
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var moreBtnName: UIButton!
    
}

