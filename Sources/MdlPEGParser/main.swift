import Foundation
import SwiftPEG

let markdownSyntax = #"""
    raw_text = ~"[^\n]+"
    bold_text = ("**" raw_text "**") / ("__" raw_text "__")
    text = (bold_text / raw_text)

    h1 = "# " text
    h2 = "## " text
    h3 = "### " text
    h4 = "#### " text
    h5 = "##### " text
    h6 = "######" text
    header = (h6 / h5 / h4 / h3 / h2 / h1)

    ordered_list = (~"[0~9]+\. " text ~"\n")+

    unordered_list = (~"[-*+] " text ~"\n")+

    link = "[" raw_text "]" "(" raw_text ")"

    image = "![" raw_text "]" "(" raw_text ")"

    paragraph = (header / text)?
    doc = (paragraph ~"\n\n")* paragraph
"""#
let markdownText = "# bla bla ## bla ### bla"
let markdownParser: Grammar = Grammar(rules: markdownSyntax)

// [] optional
// {} zero or more

let testSyntax = #"""
        root = ab+
        ab = a / b
        a = "a"
        b = "b"
"""#


let mdlSyntax = #"""
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
        additional_positional_argument = "," _ positional_argument
        _ = whitespace
        whitespace = ~"\s*"
"""#

//let text = "(bla: laber, bla: laber)"
let text = "(pos, pos, bla: laber)"

//let syntax = testSyntax
let syntax = mdlSyntax

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

