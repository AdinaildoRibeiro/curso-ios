//: Playground - noun: a place where people can play

import Foundation

let ribeiro = Pessoa(comNome: "Ribeiro", eIdade: 24)

print(ribeiro)


// checando idade
print("***** Checando idade *****")
ribeiro.idade = nil
print(ribeiro)
if let idade = ribeiro.idade{
    print(idade)
}else {
    print("Idade nula")
}


// checando endereco
print("***** Checando Endereco *****")
print(ribeiro.endereco?.formatado())
ribeiro.endereco = Endereco(rua: "Rua teste", numero: 10)
//print(ribeiro.endereco?.formatado())

// optional do optional
// exemplo 1
if let endereco = ribeiro.endereco{
    if let complemento = endereco.complemento{
        print(complemento)
    }
}

// exemplo 2
ribeiro.endereco?.complemento?.append("b")

ribeiro.endereco?.complemento = "Complemento teste"
// exemplo 3
guard let endereco = ribeiro.endereco else { fatalError() }

guard let complemento = endereco.complemento else { fatalError() }

print(complemento)