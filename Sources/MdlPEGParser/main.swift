import Foundation
import SwiftPEG

// [] optional
// {} zero or more

let syntax = #"""
        root = _ version import* global_declarations

        global_declarations = "export"? _ global_declaration

        global_declaration = function_declaration

        function_declaration = type simple_name "(" _ parameter_list ")" _

        type = frequency_qualifier? array_type

        frequency_qualifier = "uniform" _

        array_type = simple_type

        simple_type = relative_type

        relative_type = ( "material" _ ) / ( "color" _ )

        parameter_list = parameter

        parameter = type simple_name ( "=" _ assignment_expression)? annotation_block?

        annotation_block = "[[" _ annotation ( "," _ annotation )* "]]" _

        annotation = qualified_name argument_list _

        qualified_name = ("::")? simple_name ( "::" simple_name )*

        assignment_expression = postfix_expression

        postfix_expression = primary_expression postfix?

        postfix = argument_list

        primary_expression = literal_expression / simple_type

        literal_expression = floating_literal / string_literal

        string_literal = ~"\"" ~"[A-Za-z_ ]*" ~"\"" _

        version = "mdl" _ floating_literal ";" _

        import = "import" _ qualified_import

        qualified_import = import_path "::" _ "*" ";" _

        import_path = "::" simple_name

        simple_name = identifier

        identifier = ~"[A-Za-z_]+" _

        floating_literal = ~"[0-9]*.[0-9]+"

        argument_list = "(" _ arguments ")" _
        arguments = named_arguments / positional_named_arguments

        named_arguments = named_argument additional_named_argument*
        named_argument = "bla" _ ":" _ "laber" _
        additional_named_argument = "," _ named_argument _

        positional_named_arguments = positional_argument additional_positional_argument* additional_named_argument*
        positional_argument = assignment_expression
        additional_positional_argument = "," _ positional_argument _

        _ = ignore*
        ignore = comment / whitespace
        whitespace = ~"\s*"
        comment = ~"/\*((.|\s)*?)\*/"
"""#
 
guard CommandLine.argc == 2 else {
        print("Usage: MdlPEGParser <file>")
        exit(0)
}

let fileName = CommandLine.arguments[1]
let input = try String(contentsOfFile: fileName)
let parser = Grammar(rules: syntax)

guard let ast = parser.parse(for: input, with: "root") else {
        print("Error parsing!")
        exit(-1)
}
guard let simplifiedAst = simplify(for: ast) else {
        print("Error simplifying!")
        exit(-1)
}
//print(simplifiedAst)
print("Ok.")
