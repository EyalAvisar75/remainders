//
//  MonthsViewController.swift
//  RemaindersCalendar
//
//  Created by eyal avisar on 02/06/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

class BaseMonthViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var monthsCalendar: UICollectionView!
    //@IBOutlet weak var monthLabel: UILabel!
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "December"]
    
    let daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var currentMonth = String() //to use in navbar or monthLabel
    
    var numberOfEmptyBoxes = Int() // empty boxes at start of current month
    
    var nextNumberOfEmptyBoxes = Int() // empty boxes at start of next month

    var previousNumberOfEmptyBoxes = 0 // empty boxes at start of last month
    
    var direction = 0 // 0 for current month 1 for future month -1 for past month
    
    var positionIndex = 0 // state the vars of empty boxes
    
    var chosenDate = date
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = months[month]
        monthsCalendar.dataSource = self
        monthsCalendar.delegate = self
    }
    

    func getStartDateDayPosition() { //determining the # of empty boxes
        switch direction {
        case 0: //refers to current month
            switch day {
            case 1...7:
                numberOfEmptyBoxes = weekday - day
            case 8...14:
                numberOfEmptyBoxes = weekday - day - 7
            case 15...21:
                numberOfEmptyBoxes = weekday - day - 14
            case 22...28:
                numberOfEmptyBoxes = weekday - day - 21
            case 29...31:
                numberOfEmptyBoxes = weekday - day - 28
            default:
                break
            }
            positionIndex = numberOfEmptyBoxes
        case 1...: //refers to future months
            nextNumberOfEmptyBoxes = (daysInMonth[month] - positionIndex) % 7
            positionIndex = numberOfEmptyBoxes
            if previousNumberOfEmptyBoxes == 7 {
                previousNumberOfEmptyBoxes = 0
            }
        case -1: //refers to past months
            nextNumberOfEmptyBoxes = (daysInMonth[month] - positionIndex) % 7
            if previousNumberOfEmptyBoxes == 7 {
                previousNumberOfEmptyBoxes = 0
            }
            positionIndex = previousNumberOfEmptyBoxes
        default:
            fatalError()
        }
    }
    
    // MARK: uicollection view delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = .cyan
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = Int(cell.dateLabel.text!)! + 1
        chosenDate = calendar.date(from: dateComponents)!
        print(chosenDate)
    }
    // MARK: uicollection view datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return daysInMonth[month]
        switch direction {
        case 0:
            return daysInMonth[month] + numberOfEmptyBoxes
        case 1...:
            return daysInMonth[month] + nextNumberOfEmptyBoxes
        case -1:
            return daysInMonth[month] + previousNumberOfEmptyBoxes
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DateCollectionViewCell
        
        if cell.isHidden {//reuse of hidden cell
            cell.isHidden = false
        }
        switch direction {
        case 0:
            cell.dateLabel.text = "\(indexPath.row + 1 - numberOfEmptyBoxes)"
        case 1...:
            cell.dateLabel.text = "\(indexPath.row + 1 - nextNumberOfEmptyBoxes)"
        case -1:
            cell.dateLabel.text = "\(indexPath.row + 1 - previousNumberOfEmptyBoxes)"
        default:
            fatalError()
        }
        
        
        if Int(cell.dateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        //cell.dateLabel.text = "\(indexPath.row + 1)"
        if currentMonth == months[calendar.component(.month, from: date)] &&
           year == calendar.component(.year, from: date) &&
            indexPath.row + 1 == day {
            cell.backgroundColor = .red
        }
        return cell
    }

}
	
