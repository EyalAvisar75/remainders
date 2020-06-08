//
//  ViewController.swift
//  RemaindersCalendar
//
//  Created by eyal avisar on 05/06/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

class MonthViewController: BaseMonthViewController {

    @IBOutlet weak var monthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monthLabel.text = currentMonth
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let weekView = segue.destination as! WeekViewController
        weekView.receivedDay = day
        weekView.receivedDate = calendar.component(.weekday, from: date)
    }
    


}
