//
//  CronometroViewController.swift
//  IOmamma
//
//  Created by Student on 30/08/22.
//  Copyright © 2022 Student. All rights reserved.
//

import UIKit

class CronometroViewController: UIViewController {
    
    var tempoDoCronometro: Int?
    var intervaloDoCronometro: Int?
    var timer = Timer()
    var minutosTempo = 0
    var minutosIntervalo = 0
    var segundos = 0
    var minutosAux = 0

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var intervaloLabel: UILabel!
    @IBOutlet weak var tempoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempoLabel.text = String(tempoDoCronometro!)
        intervaloLabel.text = String(intervaloDoCronometro!)
        
        minutosTempo = tempoDoCronometro! - 1
        minutosAux = minutosTempo
        segundos = 60
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counterTempo), userInfo: nil, repeats: true)
    }
    
    @objc func counterTempo() {
        segundos -= 1
        var segundoslabel = String(segundos)
        var minutoslabel = String(minutosTempo)
        
        if(segundos == -1) {
            minutosTempo -= 1
            segundos = 59
        }
        
        if(minutosTempo < 10) {
            minutoslabel = "0" + String(minutosTempo)
        }
        
        if(segundos < 10) {
            segundoslabel = "0" + String(segundos)
        }
        
        if(segundos == 0 && minutosTempo == 0) {
            segundos = 60
            
            if(minutosAux == (tempoDoCronometro! - 1)) {
                minutosAux = intervaloDoCronometro! - 1
                minutosTempo = minutosAux
                
            } else if(minutosAux == (intervaloDoCronometro! - 1)) {
                
                minutosAux = tempoDoCronometro! - 1
                minutosTempo = minutosAux
            }
        }
        
        
        timerLabel.text = minutoslabel + ":" + segundoslabel
    }
  
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
