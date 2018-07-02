//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Pessoa{
    
    let nome:String
    var idade:Int!
    
    init( nome:String , idade:Int){
        self.nome = nome
        self.idade = idade
    }
    
    init( comNome nome:String , eIdade idade:Int){
        self.nome = nome
        self.idade = idade
    }
    func apresentar() -> Void{
        print("Olá, sou (nome) e tenho (idade) anos")
    }
}

//let ribeiro = Pessoa()
//ribeiro.nome = "Adinaildo"
//ribeiro.idade = 24

let ribeiro = Pessoa(nome:"Ribeiro", idade:25)

let ribeiro2 = Pessoa(comNome:"Ribeiro2", eIdade:24)

ribeiro.apresentar()