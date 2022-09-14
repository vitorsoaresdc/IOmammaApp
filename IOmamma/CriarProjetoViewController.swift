//
//  CriarProjetoViewController.swift
//  IOmamma
//
//  Created by Student on 26/08/22.
//  Copyright © 2022 Student. All rights reserved.
//

import UIKit

class CriarProjetoViewController: UIViewController {
    
    @IBOutlet weak var nomeDoProjetoTextField: UITextField!
    @IBOutlet weak var intervaloDoProjetoTextField: UITextField!
    @IBOutlet weak var tempoDoProjetoTextField: UITextField!
    @IBOutlet weak var cronometroStack: UIStackView!
    @IBOutlet weak var imageButton: UIButton!
    
    
    var categoria: String = ""
    var toggle: Bool = true
    var tempoDoProjeto: Int = 0
    var intervaloDoProjeto: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
 

    }
    
    
    @IBAction func botaoEstudo(_ sender: Any) {
        categoria = "estudo"
        
    }
    
    @IBAction func botaoTrabalho(_ sender: Any) {
        categoria = "trabalho"
    }
    
    @IBAction func botaoSaude(_ sender: Any) {
        categoria = "saude"
    }
    
    @IBAction func botaoFinancas(_ sender: Any) {
        categoria = "financas"
    }
    
    @IBAction func botaoViagens(_ sender: Any) {
        categoria = "viagens"
    }
    
    
    @IBAction func toggleTimer(_ sender: Any) {
        if toggle {
            toggle = false
            imageButton.setImage(UIImage(named: "marcado.png"), for: .normal)
            UIView.animate(withDuration: 0.25, animations: {
                self.cronometroStack.isHidden = true
                self.view.layoutIfNeeded()
            })
            
            tempoDoProjeto = 0
            intervaloDoProjeto = 0
            
        } else {
            toggle = true
            imageButton.setImage(UIImage(named: "desmarcado.png"), for: .normal)
            UIView.animate(withDuration: 0.25, animations: {
                self.cronometroStack.isHidden = false
                self.view.layoutIfNeeded()
            })

        }
    }
    
    var enviaBD = ProjetoAPI(nomeDoProjeto: " ", categoriaDoProjeto: " ", tempoDoProjeto: 0, intervaloDoProjeto: 0, tarefasDoProjeto: [])
    
    
    @IBAction func botaoConcluido(_ sender: Any) {
        
        guard (!((nomeDoProjetoTextField.text ?? "").isEmpty) && !(categoria == "")) else {
            let alert = UIAlertController(title: "Alerta", message: "Adicione um nome e categoria para o projeto", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }


         
         let url = URL(string: "link banco de dados")
         guard let requestUrl = url else { fatalError() }

         var request = URLRequest(url: requestUrl)
         request.httpMethod = "POST"

         // Set HTTP Request Header
         request.setValue("application/json", forHTTPHeaderField: "Accept")
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //tempoDoProjetoTextField.text = String(tempoDoProjeto)
        //intervaloDoProjetoTextField.text = String(intervaloDoProjeto)
        
         enviaBD = ProjetoAPI(nomeDoProjeto: nomeDoProjetoTextField.text!,
                              categoriaDoProjeto: categoria,
                              tempoDoProjeto: Int(tempoDoProjetoTextField.text ?? "0")!,
                              intervaloDoProjeto: Int(intervaloDoProjetoTextField.text ?? "0")!,
                              tarefasDoProjeto: []);
         
         let jsonData = try! JSONEncoder().encode(enviaBD)

         request.httpBody = jsonData

             let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                 
                 if let error = error {
                     print("Error took place \(error)")
                     return
                 }
                 guard let data = data else {return}

                 do{
                     let todoItemModel = try! JSONDecoder().decode(ProjetoAPI.self, from: data)
                     print("Response data:\n \(todoItemModel)")
                     print("todoItemModel Title: \(todoItemModel.nomeDoProjeto)")
                     print("todoItemModel id: \(todoItemModel.tempoDoProjeto )")
                 } catch let jsonErr{
                     print(jsonErr)
                }

          
         }
         task.resume()
        

        _ = navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
