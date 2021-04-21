import Foundation
import SwiftPEG

// [] optional
// {} zero or more

let syntax = #"""
        root = argument_list

        argument_list = "(" _
                                arguments
                        ")" _

        arguments = named_arguments / positional_named_arguments

        named_arguments = named_argument additional_named_argument*
        named_argument = "bla" _ ":" _ "laber"
        additional_named_argument = "," _ named_argument _

        positional_named_arguments = positional_argument additional_positional_argument* additional_named_argument*
        positional_argument = "pos" _
        additional_positional_argument = "," _ positional_argument _

        _ = whitespace
        whitespace = ~"\s*"
"""#

let text = "(pos, pos, bla: laber, bla: laber)"

let parser = Grammar(rules: syntax)

guard let ast = parser.parse(for: text, with: "root") else {
        print("Error")
        exit(-1)
}
guard let simplifiedAst = simplify(for: ast) else {
        print("Error")
        exit(-1)

}
print(simplifiedAst)

