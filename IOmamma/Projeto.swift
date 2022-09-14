//
//  Projeto.swift
//  IOmamma
//
//  Created by Student on 26/08/22.
//  Copyright © 2022 Student. All rights reserved.
//

import Foundation

struct ProjetoAPI: Codable {
    
    let nomeDoProjeto: String
    let categoriaDoProjeto: String
    let tempoDoProjeto: Int
    let intervaloDoProjeto: Int
    let tarefasDoProjeto: [TarefaAPI]
    
}
