//
//  ViewController.swift
//  TableViewController
//
//  Created by Eduardo Hoyos on 5/19/17.
//  Copyright © 2017 Jcodee SAC. All rights reserved.
//

import UIKit

struct Question {
    var questionName : String?
    var answers : [String]?
    var selectedIndex : Int?
}
class QuestionViewController: UITableViewController {

    let cellId = "cellId"
    let headerId = "headerId"
    
    var question = Question(questionName: "What's your favourite food?", answers: ["Pizza", "Salad", "Hamburguers", "Arroz con pollo"],selectedIndex: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        //Registrando los ids para la celda y el header
        tableView.register(AnswerCell.self, forCellReuseIdentifier: cellId)
        tableView.register(HeaderQuestion.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        //Color de letra del navigation Bar
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.title = "Question"
        //Cambiando el nombre del barButtonItem
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        //Agregando altura a la celda del Header del tableView
        tableView.sectionHeaderHeight = 50
        
        //Esconde las líneas de las celdas que no tienen info
        tableView.tableFooterView = UIView()
    }
    
    //Función para personalizar la info de cada celda
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnswerCell
        cell.nameLabel.text = question.answers?[indexPath.row]
        return cell
    }
    
    //Función que devuelve el número de filas del tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = question.answers?.count {
            return count
        }
        return 0
    }
    
    //Función para personalizar la info del header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! HeaderQuestion
        header.nameLabel.text = question.questionName
        return header
    }
    
    //Método que activa la selección en cada celda
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        question.selectedIndex = indexPath.row
        let controller = ResultsController()
        controller.question = question
        navigationController?.pushViewController(controller, animated: true)
    }

}

//Clase ViewController para recibir la respuesta de la encuenta
class ResultsController : UIViewController {
    
    var question : Question? {
        //Función previa para hacer una pequeña lógica antes de soltar el proceso de creación de esta variable
        didSet {
            let names = ["Carlos", "Juan", "Lalo", "Isaias"]
            let result = names[question!.selectedIndex!]
            
            resultsLabel.text = "Congratulations \(result)"
        }
    }
    
    //Vista Label
    let resultsLabel : UILabel = {
        let label = UILabel()
        label.text = "Congratulations!"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Titulo
        navigationItem.title = "Results"
        //Color de fondo del view controller
        view.backgroundColor = UIColor.white
        
        //Agregando la vista
        view.addSubview(resultsLabel)
        //Agregando constraints
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":resultsLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":resultsLabel]))
    }
}

//Clase para el Header del tableView
class HeaderQuestion : UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Creando la vista
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Question Header"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Preparando los objetos
    func setUpView() {
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel]))
    }
}

//Clase para la celda del tableView
class AnswerCell : UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Vista Label
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Preparando la vista
    func setUpView() {
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel]))
    }
    
    
    
}
