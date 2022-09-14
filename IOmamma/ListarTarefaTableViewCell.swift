//
//  ListarTarefaTableViewCell.swift
//  IOmamma
//
//  Created by Student on 26/08/22.
//  Copyright © 2022 Student. All rights reserved.
//

import UIKit

class ListarTarefaTableViewCell: UITableViewCell {

    @IBOutlet weak var imageBotao: UIButton!
    var estaAtivo: Bool = false
    
    @IBAction func mudarImagemDoBotao(_ sender: Any) {
        
        if estaAtivo {
            estaAtivo = false
            
            imageBotao.setImage(UIImage(named: "desmarcado.png"), for: .normal)
            
            
        } else {
            estaAtivo = true
            imageBotao.setImage(UIImage(named: "marcado.png"), for: .normal)

            
        }

    }
    
    @IBOutlet weak var dataLimiteDaTarefaLabel: UILabel!
    @IBOutlet weak var nomeDaTarefaLabel: UILabel!
    
}
