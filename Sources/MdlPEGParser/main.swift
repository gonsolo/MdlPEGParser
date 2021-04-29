import Foundation
import SwiftPEG

// [] zero or one (optional)
// {} zero or more

let syntax = #"""
        root = _ version import* global_declarations 

        global_declarations = "export"? _ global_declaration

        global_declaration = function_declaration

        function_declaration = type simple_name
                               "(" _ parameter_list ")" _ annotation_block _
                               "=" _ expression ";" _

        expression = assignment_expression

        type = frequency_qualifier? array_type

        frequency_qualifier = "uniform" _

        array_type = simple_type

        simple_type = relative_type

        relative_type = material                /
                        color                   /
                        float3                  /
                        float                   /
                        ( identifier ( "::" relative_type )? )

        material = "material" !identifier _

        color = "color" !identifier _

        float3 = "float3" !identifier _

        float = "float" !identifier _

        parameter_list = parameter ( "," _ parameter )*

        parameter = type simple_name ( "=" _ assignment_expression)? annotation_block?

        annotation_block = "[[" _ annotation ( "," _ annotation )* "]]" _

        annotation = qualified_name argument_list _

        qualified_name = ("::")? simple_name ( "::" simple_name )*

        assignment_expression = logical_or_expression

        logical_or_expression = logical_and_expression

        logical_and_expression = inclusive_or_expression

        inclusive_or_expression = exclusive_or_expression

        exclusive_or_expression = and_expression

        and_expression = equality_expression

        equality_expression = relational_expression

        relational_expression = shift_expression

        shift_expression = additive_expression

        additive_expression = multiplicative_expression

        multiplicative_expression = unary_expression ( "*" _ multiplicative_expression )*

        unary_expression = let_expression / postfix_expression

        let_expression =        "let" _
                                "{" _ variable_declaration ( variable_declaration )* "}" _
                                "in" _ unary_expression

        variable_declaration = type variable_declarator ";" _

        variable_declarator = simple_name ( "=" _ assignment_expression )?

        postfix_expression = primary_expression ( argument_list / ( "." _ simple_name) )*

        primary_expression = literal_expression / simple_type

        literal_expression =    floating_literal
                           / integer_literal
                           /    ( string_literal ( string_literal )* )

        integer_literal = ~"[0-9]+"

        string_literal = ~"\"" ~"[0-9A-Za-z.',_ ]*" ~"\"" _

        version = "mdl" _ floating_literal ";" _

        import = "import" _ qualified_import

        qualified_import = import_path "::" _ "*" ";" _

        import_path = "::" simple_name

        simple_name = identifier

        identifier = ~"[A-Za-z0-9_]+" _

        floating_literal = ~"[0-9]*.[0-9]+" _

        argument_list = "(" _
                        (
                                ( named_argument ( "," _ named_argument )* )
                                /
                                ( positional_argument ( "," _ positional_argument )* ( "," named_argument )* )
                        )?
                        ")" _

        named_argument = simple_name ":" _ assignment_expression

        positional_argument = assignment_expression

        _ = ignore*

        ignore = block_comment / line_comment / whitespace

        whitespace = ~"\s*"

        block_comment = ~"/\*((.|\s)*?)\*/"

        line_comment = ~"//((.|\s)*?)\n"
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
print("Parsing ok.")
