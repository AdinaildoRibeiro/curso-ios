import Foundation

public class Pessoa {
    public let nome: String!
    public var idade: Int?
    // set privado
    // public private(set) var endereco: Endereco?
    
    public var endereco: Endereco?
    
    public init(comNome nome:String!, eIdade idade:Int!){
        self.nome = nome
        self.idade = idade
    }
    
}

extension Pessoa: CustomStringConvertible{
    public var description: String {
        return "{ 'nome':' \(nome)', ídade':'\(idade ?? 0)' }"
    }
}
