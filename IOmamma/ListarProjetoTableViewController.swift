//
//  ListarProjetoTableViewController.swift
//  IOmamma
//
//  Created by Student on 26/08/22.
//  Copyright © 2022 Student. All rights reserved.
//

import UIKit



class ListarProjetoTableViewController: UITableViewController, ListarProjetoTableViewCellDelegate {
   
    var cellButton = 0
    
    func didPressButton(_ tag: Int) {
        self.cellButton = tag
   }
    
    var projetos = [ProjetoAPI]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = hexStringToUIColor(hex: "#F0FFFE")
        
        downloadJSON {
            self.tableView.reloadData()
            print("success")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.backgroundColor = hexStringToUIColor(hex: "#F0FFFE")
        
        downloadJSON {
           // self.tableView.reloadData()
            print("success")
        }
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        downloadJSON {
            self.tableView.reloadData()
            print("success")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return projetos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "projetos", for: indexPath)
        
        if let projetosCell = cell as? ListarProjetoTableViewCell {
            projetosCell.cellDelegate = self
            projetosCell.btn.tag = indexPath.row
            let projetosArray = projetos[indexPath.row]
            
            projetosCell.nomeDoProjetoLabel.text = projetosArray.nomeDoProjeto
            
            projetosCell.tempoDoCronometroLabel.text = String(projetosArray.tempoDoProjeto)
            projetosCell.intervaloDoCronometroLabel.text = String(projetosArray.intervaloDoProjeto)
            projetosCell.corDaCategoriaImage.image = UIImage(named: projetosArray.categoriaDoProjeto)

            return projetosCell
        }

        return cell
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
    let url = URL(string: "link banco de dados")
    
    URLSession.shared.dataTask(with: url!) { data, response, err in
        
        if err == nil {
            do {
                self.projetos = try JSONDecoder().decode([ProjetoAPI].self, from: data!)
                DispatchQueue.main.async {
                    completed()
                }
            }
            catch {
                print("error fetching data from API")
            }
        }
        }.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
        if segue.identifier == "segueListarTarefa"{
            if let viewListarTarefa = segue.destination as? ListarTarefaTableViewController {
                let celulaSelecionada = tableView.indexPathForSelectedRow?.row
                let tarefasDaCelula = projetos[celulaSelecionada!]
                viewListarTarefa.tarefas = tarefasDaCelula.tarefasDoProjeto
            }
        }
        
        if segue.identifier == "segueCronometro" {
            if let viewCronometro = segue.destination as? CronometroViewController {
                //let celSelecionada = tableView.indexPathForSelectedRow?.row
                
                
                let projetoSelecionado = projetos[cellButton]
                
                viewCronometro.tempoDoCronometro = projetoSelecionado.tempoDoProjeto
                viewCronometro.intervaloDoCronometro = projetoSelecionado.intervaloDoProjeto
                
                
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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




    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
