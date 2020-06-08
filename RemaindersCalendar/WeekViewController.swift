//
//  WeekViewController.swift
//  RemaindersCalendar
//
//  Created by eyal avisar on 05/06/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

class WeekViewController: BaseMonthViewController {

    var receivedDate = 0
    var receivedDay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekCell", for: indexPath) as! DateCollectionViewCell
        let dayIndex = receivedDate - 1
        let dateUpdater = indexPath.row - dayIndex
        var dateText = (receivedDay + dateUpdater)
        if dateText < 1 {
            dateText += daysInMonth[month]
        }
        else if dateText > daysInMonth[(month + 1) % 12] {
            dateText -= daysInMonth[month + 1]
        }
        cell.dateLabel.text = String("\(dateText)")
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = .cyan
    }
}
