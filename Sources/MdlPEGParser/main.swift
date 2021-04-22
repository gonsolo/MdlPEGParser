import Foundation
import SwiftPEG

// [] optional
// {} zero or more

let syntax = #"""
        root = argument_list

        argument_list = "(" _ arguments ")" _
        arguments = named_arguments / positional_named_arguments

        named_arguments = named_argument additional_named_argument*
        named_argument = "bla" _ ":" _ "laber" _
        additional_named_argument = "," _ named_argument _

        positional_named_arguments = positional_argument additional_positional_argument* additional_named_argument*
        positional_argument = "pos" _
        additional_positional_argument = "," _ positional_argument _

        _ = whitespace
        whitespace = ~"\s*"
"""#

guard CommandLine.argc == 2 else {
        print("Usage: MdlPEGParser <file>")
        exit(0)
}

let fileName = CommandLine.arguments[1]
let input = try String(contentsOfFile: fileName)

let parser = Grammar(rules: syntax)

guard let ast = parser.parse(for: input, with: "root") else {
        print("Error!")
        exit(-1)
}
guard let simplifiedAst = simplify(for: ast) else {
        print("Error!")
        exit(-1)

}
//print(simplifiedAst)
print("Ok.")
