//
//  ListarProjetoTableViewCell.swift
//  IOmamma
//
//  Created by Student on 26/08/22.
//  Copyright © 2022 Student. All rights reserved.
//

import UIKit

class ListarProjetoTableViewCell: UITableViewCell {
        
    @IBOutlet weak var corDaCategoriaImage: UIImageView!
    @IBOutlet weak var intervaloDoCronometroLabel: UILabel!
    @IBOutlet weak var nomeDoProjetoLabel: UILabel!
    @IBOutlet weak var tempoDoCronometroLabel: UILabel!
    @IBOutlet weak var stackViewTempo: UIStackView!
    
    var cellDelegate: ListarProjetoTableViewCellDelegate?
    
        @IBOutlet weak var btn: UIButton!
       
       @IBAction func buttonPressed(_ sender: UIButton) {
           cellDelegate?.didPressButton(sender.tag)
       }
}

protocol ListarProjetoTableViewCellDelegate : class {
    func didPressButton(_ tag: Int)
}


