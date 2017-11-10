import Foundation

enum Token {
    case number(Int)
    case plus
}

class Lexer {
    let input: String.CharacterView
    var position: String.CharacterView.Index
    
    enum Error: Swift.Error {
        case invalidCharacter(Character)
    }
    
    init(input: String) {
        self.input = input.characters
        self.position = self.input.startIndex
    }
    
    func peek() -> Character? {
        guard position < input.endIndex else {
            return nil
        }
        return input[position]
    }

    func advance() {
        assert(position < input.endIndex, "Cannot advance past endIndex!")
        position = input.index(after: position)
    }

    func getNumber() -> Int {
        var value = 0
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0" ... "9":
                // Another digit - add it into value
                let digitValue = Int(String(nextCharacter))!
                value = 10*value + digitValue
                advance()
                
            default:
                // A nondigit - go back to regular lexing
                return value
            }
        }
        
        return value
    }
    
    func lex() throws -> [Token] {
        var tokens = [Token]()
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0" ... "9":
                let value = getNumber()
                tokens.append(.number(value))

            case "+":
                tokens.append(.plus)
                advance()
                
            case " ":
                // Just advance to ignore spaces
                advance()
                
            default:
                throw Lexer.Error.invalidCharacter(nextCharacter)
            }
        }
        
        return tokens
    }
}

func evaluate(_ input: String) {
    print("Evaluating: \(input)")
    let lexer = Lexer(input: input)
    do {
        let tokens = try lexer.lex()
        print("Lexer output: \(tokens)")
    } catch Lexer.Error.invalidCharacter(let character) {
        print("Input contained an invalid character: \(character)")
    } catch {
        print("An error occurred: \(error)")
    }
}

class Parser {
    let tokens: [Token]
    var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    func getNextToken() -> Token? {
        guard position < tokens.count else {
            return nil
        }
        let token = tokens[position]
        position += 1
        return token
    }
}

evaluate("10 + 3 + 5")
evaluate("1 + 2 + 8")

