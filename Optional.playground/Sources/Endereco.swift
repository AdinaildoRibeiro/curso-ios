import Foundation

public class Endereco{
    public var rua: String
    public var numero: Int
    public var complemento: String?
    
    public init(rua:String, numero:Int){
        self.rua = rua
        self.numero = numero
    }
    
    public func formatado() -> String{
        return "Rua: \(rua) , numero: \(numero) "
    }
    
}
