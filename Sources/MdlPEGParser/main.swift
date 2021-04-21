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

let mdlSyntax = #"""
        mdl = argument_list+
        argument_list = _ "(" _ named_argument _ ")" _
        named_argument = "bla" _ ":" _ "laber" _
        _ = whitespace
        whitespace = ~"\s*"
"""#

let mdlText = " ( bla:   laber ) "

let mdlParser = Grammar(rules: mdlSyntax)

guard let ast = mdlParser.parse(for: mdlText, with: "mdl") else {
        print("Error")
        exit(-1)
}
guard let simplifiedAst = simplify(for: ast) else {
        print("Error")
        exit(-1)

}
print(simplifiedAst)

