# SYNTAX TEST "TCL.sublime-syntax"

##############################################################################
# [1] Commands
#
# A Tcl script is a string containing one or more commands. Semicolons and
# newlines are command separators unless quoted as described below. Close
# brackets are command terminators during command substitution unless quoted.
##############################################################################

    cmd arg1 arg2; cmd arg1 arg2
#  ^ - meta.function-call
#   ^^^ meta.function-call.tcl - meta.function-call.parameters.tcl
#      ^^^^^^^^^^ meta.function-call.parameters.tcl - meta.function-call.tcl
#                ^ punctuation.terminator.command.tcl
#                 ^ - meta.function-call
#                  ^^^ meta.function-call.tcl
#                     ^^^^^^^^^^ meta.function-call.parameters.tcl
#  ^ - variable.function.tcl
#   ^^^ variable.function.tcl
#      ^ - variable.function.tcl

    cmd\
#   ^^^^ meta.function-call.tcl - meta.function-call.parameters.tcl
#       ^ meta.function-call.parameters.tcl - meta.function-call.tcl
#   ^^^ variable.function.tcl
#      ^ punctuation.separator.continuation.newline.tcl
    arg1\
#   ^^^^ - variable.function
#       ^ punctuation.separator.continuation.newline.tcl
    arg2
#   ^^^^ - variable.function

    cmd \
#   ^^^ variable.function.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    arg1 \
#   ^^^^ - variable.function
#        ^ punctuation.separator.continuation.newline.tcl
    arg2
#   ^^^^ - variable.function

    cmd \; v]text [v]text
#       ^^ constant.character.escape.other.tcl
#           ^ - punctuation
#                 ^ punctuation.section.substitution.begin.tcl
#                 ^^^ meta.substitution.tcl
#                   ^ punctuation.section.substitution.end.tcl

    cmd -switch "arg" -sw2 -- -noswitch
#   ^^^ variable.function.tcl
#       ^^^^^^^ variable.parameter.tcl
#               ^^^^^ string.quoted.double.tcl
#                     ^^^^ variable.parameter.tcl
#                          ^^ punctuation.terminator.switches.tcl
#                             ^^^^^^^^^ - variable.parameter

    cmd\
#   ^^^ variable.function.tcl
#      ^ punctuation.separator.continuation.newline.tcl
    -switch\
#   ^^^^^^^ variable.parameter.tcl
#          ^ punctuation.separator.continuation.newline.tcl
    "arg"\
#   ^^^^^ string.quoted.double.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    -sw2\
#   ^^^^ variable.parameter.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    --\
#   ^^ punctuation.terminator.switches.tcl
#     ^ punctuation.separator.continuation.newline.tcl
    -noswitch
#   ^^^^^^^^^ - variable.parameter

    [cmd arg][cmd arg] {puts "str"}
#   ^^^^^^^^^^^^^^^^^^ meta.function-call.tcl
#                     ^^^^^^^^^^^^^^ meta.function-call.parameters.tcl

    "cmd" arg arg
#   ^^^^^ meta.function-call.tcl
#        ^^^^^^^^^ meta.function-call.parameters.tcl

    {cmd} arg arg
#   ^^^^^ meta.function-call.tcl
#        ^^^^^^^^^ meta.function-call.parameters.tcl

    $cmd arg arg
#   ^^^^ meta.function-call.tcl
#       ^^^^^^^^^ meta.function-call.parameters.tcl

    ${cmd(test)} arg arg
#   ^^^^^^^^^^^^ meta.function-call.tcl
#               ^^^^^^^^^ meta.function-call.parameters.tcl

    ${ns}::func arg arg
#   ^^^^^^^^^^^ meta.function-call.tcl
#              ^^^^^^^^^ meta.function-call.parameters.tcl

    ns::func arg arg
#   ^^^^^^^^ meta.function-call.tcl
#           ^^^^^^^^^ meta.function-call.parameters.tcl

# simple builtin commands/functions
    pow x 10
#   ^^^ support.function.builtin.tcl
#   ^^^ meta.function-call.tcl
#      ^^^^^ meta.function-call.parameters.tcl
#         ^^ constant.numeric.integer.tcl

    pow\
#   ^^^ meta.function-call.tcl support.function.builtin.tcl
#      ^^ meta.function-call.parameters.tcl
#      ^ punctuation.separator.continuation.newline.tcl
    x\
#  ^^^^ meta.function-call.parameters.tcl
#    ^ punctuation.separator.continuation.newline.tcl
    10
#  ^^^ meta.function-call.parameters.tcl
#   ^^ constant.numeric.integer.tcl

##############################################################################
# [3] Words
#
# Words of a command are separated by white space
# (except for newlines, which are command separators).
##############################################################################


##############################################################################
# [4] Double quotes
#
# If the first character of a word is double quote (“"”) then the word is
# terminated by the next double quote character. Semicolons, close brackets,
# or white space characters (including newlines) are treated as ordinary
# characters and included in the word.
##############################################################################

    "foo } ] ; # bar \" \
#   ^ punctuation.definition.string.begin.tcl
#   ^^^^^^^^^^^^^^^^^ string.quoted.double.tcl
#        ^ - punctuation
#          ^ - punctuation
#            ^ - punctuation
#              ^ - punctuation
#              ^^^^^^^^ - comment
#                    ^^ constant.character.escape.other.tcl
#                       ^ - punctuation
    "
#^^^^ string.quoted.double.tcl
#   ^ punctuation.definition.string.end.tcl
#    ^ - string - punctuation

# Command substitution, variable substitution, and backslash substitution are performed
    "$foo ${bar + 2} \h [set x "str"]""invalid"
#  ^ - string - punctuation
#   ^ punctuation.definition.string.begin.tcl
#   ^^^^^^^^^^^^^^^^^^^^^^^ string.quoted.double.tcl
#    ^ punctuation.definition.variable.tcl
#    ^^^^ variable.other.tcl
#        ^ - variable.other
#         ^^ punctuation.definition.variable.begin.tcl
#         ^^^^^^^^^^ variable.other.tcl
#                  ^ punctuation.definition.variable.end.tcl
#                   ^ - constant - variable.other
#                    ^^ constant.character.escape.other.tcl
#                      ^ - constant - meta.substitution
#                       ^ punctuation.section.substitution.begin.tcl
#                       ^^^^^^^^^^^^^ meta.substitution.tcl
#                        ^^^ keyword.other.builtin.tcl
#                            ^ variable.other.tcl
#                              ^ punctuation.definition.string.begin.tcl
#                              ^^^^^ string.quoted.double.tcl
#                                  ^ punctuation.definition.string.end.tcl
#                                   ^ punctuation.section.substitution.end.tcl
#                                    ^ punctuation.definition.string.end.tcl
#                                     ^ - string - punctuation
#                                     ^^^^^^^^^ invalid.illegal.end-of-word-expected.tcl


##############################################################################
# [5] Argument expansion
#
# If a word starts with the string “{*}” followed by a non-whitespace character,
# then the leading “{*}” is removed and the rest of the word is parsed and
# substituted as any other word.
##############################################################################

    cmd a {*}{b [c]} d {*}{$e f {g h}} {*} {1 2 3}
#         ^^^ keyword.operator.word.tcl
#            ^ punctuation.section.braces.begin.tcl
#            ^^^^^^^ meta.braces.tcl - keyword.operator.word
#                  ^ punctuation.section.braces.end.tcl
#                         ^ punctuation.section.braces.begin.tcl
#                         ^^^^^^^^^^^^ meta.braces.tcl - keyword.operator.word
#                               ^ punctuation.section.braces.begin.tcl
#                               ^^^^^ meta.braces.tcl meta.braces.tcl
#                                   ^^ punctuation.section.braces.end.tcl
#                                      ^ punctuation.section.braces.begin.tcl
#                                      ^^^ meta.braces.tcl - keyword.operator.word
#                                        ^ punctuation.section.braces.end.tcl
#                                          ^ punctuation.section.braces.begin.tcl
#                                          ^^^^^^^ meta.braces.tcl - keyword.operator.word
#                                                ^ punctuation.section.braces.end.tcl


##############################################################################
# [6] Braces
#
# If the first character of a word is an open brace (“{”) and rule [5] does
# not apply, then the word is terminated by the matching close brace (“}”).
# Braces nest within the word: for each additional open brace there must be an
# additional close brace (however, if an open brace or close brace within the
# word is quoted with a backslash then it is not counted in locating the
# matching close brace). No substitutions are performed on the characters
# between the braces except for backslash-newline substitutions described
# below, nor do semi-colons, newlines, close brackets, or white space receive
# any special interpretation. The word will consist of exactly the characters
# between the outer braces, not including the braces themselves.
##############################################################################

    {}{
#  ^ - meta.braces - punctuation
#   ^ meta.braces.tcl punctuation.section.braces.begin.tcl
#    ^ meta.braces.tcl punctuation.section.braces.end.tcl
#     ^ invalid.illegal.end-of-word-expected.tcl - meta.braces - punctuation

    {
#  ^ - meta.braces - punctuation
#   ^ punctuation.section.braces.begin.tcl
#   ^^ meta.braces.tcl
    }{
#^^^^ meta.braces.tcl
#   ^ punctuation.section.braces.end.tcl
#    ^ invalid.illegal.end-of-word-expected.tcl - meta.braces - punctuation

    {;}
#  ^ - meta.braces
#   ^ punctuation.section.braces.begin.tcl
#   ^^^ meta.braces.tcl string.quoted.brace.tcl
#    ^ - punctuation
#     ^ punctuation.section.braces.end.tcl
#      ^ - meta.braces

    {puts} {test}
#  ^ - meta.braces
#   ^ punctuation.section.braces.begin.tcl
#   ^^^^^^ meta.braces.tcl string.quoted.brace.tcl
#        ^ punctuation.section.braces.end.tcl
#         ^ - meta.braces
#          ^ punctuation.section.braces.begin.tcl
#          ^^^^^^ meta.braces.tcl string.quoted.brace.tcl
#               ^ punctuation.section.braces.end.tcl

# ----------------------------------------------------------------------------
# https://github.com/SublimeTextIssues/DefaultPackages/issues/131

set ok1 {"}
#      ^ - meta.braces
#       ^ punctuation.section.braces.begin.tcl
#       ^^^ meta.braces.tcl string.quoted.brace.tcl
#        ^ - punctuation
#         ^ punctuation.section.braces.end.tcl
#          ^ - meta.braces
set ok2 {["]"]}
#      ^ - meta.braces
#       ^ punctuation.section.braces.begin.tcl
#       ^^^^^^^ meta.braces.tcl string.quoted.brace.tcl
#        ^^^^^ - punctuation
#             ^ punctuation.section.braces.end.tcl
#              ^ - meta.braces
set ok3 {["][]"]}
#      ^ - meta.braces
#       ^ punctuation.section.braces.begin.tcl
#       ^^^^^^^^^ meta.braces.tcl string.quoted.brace.tcl
#        ^^^^^^^ - punctuation
#               ^ punctuation.section.braces.end.tcl
#                ^ - meta.braces
set ok4 {["]["]}
#      ^ - meta.braces
#       ^ punctuation.section.braces.begin.tcl
#       ^^^^^^^^ meta.braces.tcl string.quoted.brace.tcl
#        ^^^^^^ - punctuation
#              ^ punctuation.section.braces.end.tcl
#               ^ - meta.braces
set ok5 {["]["\"}"
#      ^ - meta.braces
#       ^ punctuation.section.braces.begin.tcl
#       ^^^^^^^^^ meta.braces.tcl string.quoted.brace.tcl
#        ^^^^^^^ - punctuation
#               ^ punctuation.section.braces.end.tcl
#                ^ invalid.illegal.end-of-word-expected.tcl - meta.braces

# ----------------------------------------------------------------------------
# https://github.com/sublimehq/Packages/issues/783
# https://github.com/sublimehq/Packages/issues/784

set regexp {(^[a-zA-Z]{2}[a-zA-Z0-9-]{2,12}$)}
#         ^ - meta.braces
#          ^ punctuation.section.braces.begin.tcl
#          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.braces.tcl - invalid
#                                            ^ punctuation.section.braces.end.tcl
#                                             ^ - meta.braces
set regexp {(.{0,200})}
#         ^ - meta.braces
#          ^ punctuation.section.braces.begin.tcl
#          ^^^^^^^^^^^^ meta.braces.tcl - invalid
#                     ^ punctuation.section.braces.end.tcl
#                      ^ - meta.braces

##############################################################################
# [7] Command substitution
##############################################################################

    []
#  ^ - meta.substitution
#   ^^ meta.substitution.tcl
#   ^ punctuation.section.substitution.begin.tcl
#    ^ punctuation.section.substitution.end.tcl
#     ^ - meta.substitution

    [cmd a b][expr 1 + 5] arg arg
#  ^ - meta.substitution
#   ^ punctuation.section.substitution.begin.tcl
#   ^^^^^^^^^^^^^^^^^^^^^ meta.substitution.tcl
#           ^ punctuation.section.substitution.end.tcl
#            ^ punctuation.section.substitution.begin.tcl
#                       ^ punctuation.section.substitution.end.tcl
#                        ^ - meta.substitution.tcl
#                         ^^^ - keyword

    [
#  ^ - meta.substitution - punctuation
#   ^ punctuation.section.substitution.begin.tcl
#   ^^ meta.substitution.tcl
    ]
# <- meta.substitution.tcl
#^^^^ meta.substitution.tcl
#   ^ punctuation.section.substitution.end.tcl
#    ^ - meta.substitution - punctuation

    set y [set x 0][incr x][incr x]
#        ^ - meta.substitution
#         ^^^^^^^^^^^^^^^^^^^^^^^^^ meta.substitution.tcl
#         ^ punctuation.section.substitution.begin.tcl
#                 ^ punctuation.section.substitution.end.tcl
#                  ^ punctuation.section.substitution.begin.tcl
#                         ^ punctuation.section.substitution.end.tcl
#                          ^ punctuation.section.substitution.begin.tcl
#                                 ^ punctuation.section.substitution.end.tcl
#                                  ^ - meta.substitution

    puts this_is_a_really_long_word[
#                                  ^ meta.substitution.tcl punctuation.section.substitution.begin.tcl
        ]_which_can't_have_spaces
#       ^ meta.substitution.tcl punctuation.section.substitution.end.tcl


# Command substitution is not performed on words enclosed in braces.
    set {bar [baz]}

    set saoid [svcmap_saoid sm]


##############################################################################
# [8] Variable substitution
#
# Name is the name of a scalar variable or array element. It may contain any
# characters whatsoever except for close braces. It indicates an array element
# if name is in the form “arrayName(index)” where arrayName does not contain
# any open parenthesis characters, “(”, or close brace characters, “}”, and
# index can be any sequence of characters except for close brace characters.
# No further substitutions are performed during the parsing of name.
##############################################################################

    cmd $var
#      ^ - variable.other
#       ^ punctuation.definition.variable.tcl
#       ^^^^ variable.other.tcl
#           ^ - variable.other

    cmd $var:novar
#      ^ - variable.other
#       ^ punctuation.definition.variable.tcl
#       ^^^^ variable.other.tcl
#           ^ - punctuation
#           ^^^^^^ - variable.other

    cmd pref$var[cmd arg]
#      ^^^^^ - variable.other
#           ^ punctuation.definition.variable.tcl
#           ^^^^ variable.other.tcl
#               ^ meta.substitution - variable.other

    cmd $ns::
#      ^ - variable.other
#       ^ punctuation.definition.variable.tcl
#       ^^^^^ variable.other.tcl
#          ^^ punctuation.accessor.double-colon.namespace.tcl
#            ^ - variable.other

    cmd $ns::var
#      ^ - variable.other
#       ^ punctuation.definition.variable.tcl
#       ^^^^^^^^ variable.other.tcl
#          ^^ punctuation.accessor.double-colon.namespace.tcl
#               ^ - variable.other

    cmd ${ns}::cmd
#      ^ - variable.other
#       ^^^^^ variable.other.tcl
#       ^^ punctuation.definition.variable.begin.tcl
#           ^ punctuation.definition.variable.end.tcl
#            ^^ punctuation.accessor.double-colon.namespace.tcl - variable.other

    cmd $var( arg , [set $var "x"] )
#      ^ - variable.other
#       ^ punctuation.definition.variable.tcl
#       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ variable.other.tcl
#          ^ - meta.parens
#           ^ punctuation.section.parens.begin.tcl
#           ^^^^^^^^^^^^^^^^^^^^^^^^ meta.parens.tcl
#                 ^ punctuation.separator.sequence.tcl
#                   ^ punctuation.section.substitution.begin.tcl
#                   ^^^^^^^^^^^^^^ meta.substitution.tcl
#                    ^^^ keyword.other.builtin.tcl
#                        ^ punctuation.definition.variable.tcl
#                        ^^^^ variable.other.tcl variable.other.tcl
#                                ^ punctuation.section.substitution.end.tcl
#                                  ^ punctuation.section.parens.end.tcl
#                                   ^ - meta.parens - variable.other

    cmd $ns::var( arg , [set $var "x"] )
#      ^ - variable.other
#       ^ punctuation.definition.variable.tcl
#       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ variable.other.tcl
#          ^^ punctuation.accessor.double-colon.namespace.tcl
#              ^ - meta.parens
#               ^ punctuation.section.parens.begin.tcl
#               ^^^^^^^^^^^^^^^^^^^^^^^^ meta.parens.tcl
#                     ^ punctuation.separator.sequence.tcl
#                       ^ punctuation.section.substitution.begin.tcl
#                       ^^^^^^^^^^^^^^ meta.substitution.tcl
#                        ^^^ keyword.other.builtin.tcl
#                            ^ punctuation.definition.variable.tcl
#                            ^^^^ variable.other.tcl variable.other.tcl
#                                    ^ punctuation.section.substitution.end.tcl
#                                      ^ punctuation.section.parens.end.tcl
#                                       ^ - meta.parens - variable.other

# Command substitutions, variable substitutions, and backslash substitutions
# are performed on the characters of index.

    cmd ${var-ia.b%le([set x 0], \U0B42[incr x]$idx)}
#      ^ - variable.other
#       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ variable.other.tcl
#       ^^ punctuation.definition.variable.begin.tcl
#                    ^ punctuation.section.parens.begin.tcl
#                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.parens.tcl
#                              ^ punctuation.separator.sequence.tcl
#                                                  ^ punctuation.section.parens.end.tcl
#                                                   ^ punctuation.definition.variable.end.tcl
#                                                    ^ - variable.other


# Variable substitution is not performed on words enclosed in braces.


    {$novar}

    {${name}}

    $name(idx1,idx2)

    ${arrayName(idx1,idx2)}


##############################################################################
# [9] Backslash substitution
##############################################################################

# Audible alert (bell) (0x7).
    \a
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

# Backspace (0x8).
    \b
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

# Form feed (0xc).
    \f
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

# Newline (0xa).
    \n
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

# Carriage-return (0xd).
    \r
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

# Tab (0x9).
    \t
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

# Vertical tab (0xb).
    \v
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

# Backslash
    \\
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

# Closing bracket
    \]
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

# Closing bracket
    \}
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

# Closing bracket
    \"
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

# Hashtag
    \#
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

# Eight-bit octal value for the Unicode character.
    \1
#  ^ - constant.character.escape
#   ^^ constant.character.escape.octal
#     ^ - constant.character.escape

    \19
#  ^ - constant.character.escape
#   ^^^ constant.character.escape.octal
#      ^ - constant.character.escape

    \152
#  ^ - constant.character.escape
#   ^^^^ constant.character.escape.octal
#       ^ - constant.character.escape

    \15232
#  ^ - constant.character.escape
#   ^^^^ constant.character.escape.octal
#       ^^^ - constant.character.escape

# Eight-bit hexadecimal value for the Unicode character.
# Any number of hexadecimal digits may be present; however, all but the last
# two are ignored (the result is always a one-byte quantity).
    \x
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

    \x1
#  ^ - constant.character.escape
#   ^^^ constant.character.escape.hexadecimal
#      ^ - constant.character.escape

    \x19
#  ^ - constant.character.escape
#   ^^^^ constant.character.escape.hexadecimal
#       ^ - constant.character.escape

    \x152
#  ^ - constant.character.escape
#   ^^^^^ constant.character.escape.hexadecimal
#        ^ - constant.character.escape

    \x1afbg
#  ^ - constant.character.escape
#   ^^^^^^ constant.character.escape.hexadecimal
#         ^^ - constant.character.escape

# A sixteen-bit hexadecimal value for the Unicode character
    \u
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

    \u0
#  ^ - constant.character.escape
#   ^^^ constant.character.escape.hexadecimal
#      ^ - constant.character.escape

    \u0a
#  ^ - constant.character.escape
#   ^^^^ constant.character.escape.hexadecimal
#       ^ - constant.character.escape

    \u0a5f
#  ^ - constant.character.escape
#   ^^^^^^ constant.character.escape.hexadecimal
#         ^ - constant.character.escape

    \u0ag
#  ^ - constant.character.escape
#   ^^^^ constant.character.escape.hexadecimal
#       ^ - constant.character.escape

    \u0a5fabcd
#  ^ - constant.character.escape
#   ^^^^^^ constant.character.escape.hexadecimal
#         ^^^^^ - constant.character.escape

# A thirty-two-bit hexadecimal value for the Unicode character
    \U
#  ^ - constant.character.escape
#   ^^ constant.character.escape.other
#     ^ - constant.character.escape

    \U0
#  ^ - constant.character.escape
#   ^^^ constant.character.escape.hexadecimal
#      ^ - constant.character.escape

    \U0a
#  ^ - constant.character.escape
#   ^^^^ constant.character.escape.hexadecimal
#       ^ - constant.character.escape

    \U0a5f
#  ^ - constant.character.escape
#   ^^^^^^ constant.character.escape.hexadecimal
#         ^ - constant.character.escape

    \U0a5g
#  ^ - constant.character.escape
#   ^^^^^ constant.character.escape.hexadecimal
#        ^ - constant.character.escape

    \U0a5fabcd
#  ^ - constant.character.escape
#   ^^^^^^^^^^ constant.character.escape.hexadecimal
#             ^ - constant.character.escape

    \U0a5fabcdddf
#  ^ - constant.character.escape
#   ^^^^^^^^^^ constant.character.escape.hexadecimal
#             ^^^^ - constant.character.escape


##############################################################################
# [10] Comments
#
# If a hash character (“#”) appears at a point where Tcl is expecting the
# first character of the first word of a command then the hash character and
# the characters that follow it, up through the next newline, are treated as a
# comment and ignored.
##############################################################################

    # command \
#  ^ - comment
#   ^ punctuation.definition.comment.begin.tcl
#   ^^^^^^^^^^^^ comment.line.double-dash.tcl
#             ^ - punctuation.separator.continuation.newline.tcl

    cmd#no comment
#      ^ - punctuation
#      ^^^^^^^^^^^^ - comment

    cmd # no comment
#       ^^^^^^^^^^^^^ - comment

    cmd;# no comment
#      ^ punctuation.terminator.command.tcl
#       ^ punctuation.definition.comment.begin.tcl
#       ^^^^^^^^^^^^^ comment.line.double-dash.tcl

    cmd ; # no comment
#       ^ punctuation.terminator.command.tcl
#         ^ punctuation.definition.comment.begin.tcl
#         ^^^^^^^^^^^^^ comment.line.double-dash.tcl

    cmd [# comment]
#       ^ punctuation.section.substitution.begin.tcl
#        ^ punctuation.definition.comment.begin.tcl
#        ^^^^^^^^^^^ comment.line.double-dash.tcl
#                 ^ - punctuation

        cmd [ set;# comment ];comment
#                ^ punctuation.terminator.command.tcl
#                 ^ punctuation.definition.comment.begin.tcl
#                 ^^^^^^^^^^^^^^^^^^^^ comment.line.double-dash.tcl
#                           ^^ - punctuation
            ]
#           ^ meta.substitution.tcl punctuation.section.substitution.end.tcl

        cmd [ set#no comment ]
#           ^ punctuation.section.substitution.begin.tcl
#                ^ - punctuation
#                ^^^^^^^^^^^^^^ - comment
#                            ^ punctuation.section.substitution.end.tcl

        cmd [ set # no comment ]
#           ^ punctuation.section.substitution.begin.tcl
#                 ^ - punctuation
#                 ^^^^^^^^^^^^^^^ - comment
#                              ^ punctuation.section.substitution.end.tcl
       ]
#      ^ punctuation.section.substitution.end.tcl

    set w { # no commet }
#           ^^^^^^^^^^^^^^ - comment

    set w { ; # no commet }
#             ^^^^^^^^^^^^^^ - comment

##############################################################################
# constants
##############################################################################

    cmd 1. 1.0 1.e4 1.e-4 1.0e5 4.4e-3 .1e10
#       ^^ constant.numeric.float.tcl
#          ^^^ constant.numeric.float.tcl
#              ^^^^ constant.numeric.float.tcl
#                   ^^^^^ constant.numeric.float.tcl
#                         ^^^^^ constant.numeric.float.tcl
#                               ^^^^^^ constant.numeric.float.tcl
#                                      ^^^^^ constant.numeric.float.tcl


##############################################################################
# common flow control keyword tests
##############################################################################

    break invalid ; # comment
#   ^^^^^^^^^^^^^^ meta.statement.flow.break.tcl
#   ^^^^^ keyword.control.flow.break.tcl
#        ^ - keyword - invalid
#         ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#                ^ - invalid
#                 ^ punctuation.terminator.command.tcl
#                   ^ comment.line.double-dash.tcl

    break-me
#   ^^^^^^^^^ - meta.statement.flow.break.tcl
#   ^^^^^ - keyword.control.flow

    break[incr x]
#   ^^^^^ - keyword.control.flow

    break(5)
#   ^^^^^ - keyword.control.flow

    continue "test";# comment
#   ^^^^^^^^^^^^^^^ meta.statement.flow.continue.tcl
#   ^^^^^^^^ keyword.control.flow.continue.tcl
#           ^ - keyword - invalid
#            ^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#                  ^ punctuation.terminator.command.tcl
#                   ^ comment.line.double-dash.tcl

    continue-me
#   ^^^^^^^^ - keyword.control.flow

    continue[incr x]
#   ^^^^^^^^ - keyword.control.flow

    continue(2)
#   ^^^^^^^^ - keyword.control.flow

    error;error
#   ^^^^^ meta.statement.flow.error.tcl keyword.control.flow.error.tcl
#        ^ punctuation.terminator.command.tcl - meta.statement.flow.error.tcl
#         ^^^^^ meta.statement.flow.error.tcl keyword.control.flow.error.tcl

    error error error
#   ^^^^^^^^^^^^^^^^^^ meta.statement.flow.error.tcl
#   ^^^^^ keyword.control.flow.error.tcl
#         ^^^^^ string.unquoted.tcl
#               ^^^^^ constant.language.errorcode.tcl

    error error $info error
#   ^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.flow.error.tcl
#   ^^^^^ keyword.control.flow.error.tcl
#         ^^^^^ string.unquoted.tcl
#               ^^^^^ variable.other.tcl
#                     ^^^^^ constant.language.errorcode.tcl

    exit;exit
#   ^^^^ meta.statement.flow.exit.tcl keyword.control.flow.exit.tcl
#       ^ punctuation.terminator.command.tcl
#        ^^^^ meta.statement.flow.exit.tcl keyword.control.flow.exit.tcl

    exit 0 invalid ; # comment
#   ^^^^^^^^^^^^^^^ meta.statement.flow.exit.tcl
#   ^^^^ keyword.control.flow.exit.tcl
#        ^ constant.numeric.integer.tcl
#          ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#                 ^ - invalid
#                  ^ punctuation.terminator.command.tcl
#                    ^ comment.line.double-dash.tcl
    exit [incr error]
#   ^^^^^^^^^^^^^^^^^^ meta.statement.flow.exit.tcl
#   ^^^^ keyword.control.flow.exit.tcl
#        ^^^^^^^^^^^^ meta.substitution.tcl


    return
#   ^^^^^^^ meta.statement.flow.return.tcl
#  ^ - keyword
#   ^^^^^^ keyword.control.flow.return.tcl
#         ^ - keyword
    returnme
#   ^^^^^^^^^ - keyword.control.flow

    return(1)
#   ^^^^^^^^^ - keyword.control.flow

    return 1
#   ^^^^^^^^^ meta.statement.flow.return.tcl
#  ^ - keyword
#   ^^^^^^ keyword.control.flow.return.tcl
#         ^ - keyword
#          ^ constant.numeric.integer.tcl

    return break
#   ^^^^^^^^^^^^^ meta.statement.flow.return.tcl
#  ^ - keyword
#   ^^^^^^ keyword.control.flow.return.tcl
#         ^ - keyword
#          ^^^^^ constant.language.errorcode.tcl

    return -code $code $factor
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.flow.return.tcl
#  ^ - keyword
#   ^^^^^^ keyword.control.flow.return.tcl
#         ^ - keyword
#          ^^^^^ variable.parameter.tcl
#                ^^^^^ variable.other.tcl
#                      ^^^^^^^ variable.other.tcl

    return -code error \
#   ^^^^^^^^^^^^^^^^^^^^^ meta.statement.flow.return.tcl
#  ^ - keyword
#   ^^^^^^ keyword.control.flow.return.tcl
#         ^ - keyword
#          ^^^^^ variable.parameter.tcl
#                ^^^^^ constant.language.errorcode.tcl
        "overflow computing factorial of $n"
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.flow.return.tcl
#       ^ string.quoted.double.tcl punctuation.definition.string.begin.tcl

    throw {ARITH DIVZERO {divide by zero}} {divide by zero} illegal
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.flow.throw.tcl
#   ^^^^^ keyword.control.flow.throw.tcl
#         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.braces.tcl
#                                          ^^^^^^^^^^^^^^^^ meta.braces.tcl string.quoted.brace.tcl
#                                                           ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    yield $value illegal
#   ^^^^^^^^^^^^^^^^^^^^^ meta.statement.flow.yield.tcl
#   ^^^^^ keyword.control.flow.yield.tcl
#         ^^^^^^ variable.other.tcl
#                ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    yieldto cmd $value illegal
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.flow.yieldto.tcl
#   ^^^^^^^ keyword.control.flow.yieldto.tcl
#           ^^^ string.unquoted.tcl
#               ^^^^^^ variable.other.tcl
#                      ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

##############################################################################
# after commands
##############################################################################

    set id [after 10 [puts "done!"]]
#           ^^^^^ keyword.other.builtin.tcl

    after cancel $id
#   ^^^^^ keyword.other.builtin.tcl
#         ^^^^^^ variable.function.tcl
#                ^^^ variable.other.tcl

    after\
#   ^^^^^ keyword.other.builtin.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    cancel\
#   ^^^^^^ variable.function.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    $id
#   ^^^ variable.other.tcl

    after info $id
#   ^^^^^ keyword.other.builtin.tcl
#         ^^^^ variable.function.tcl
#              ^^^ variable.other.tcl

    after idle [list after 0 doOneStep]
#   ^^^^^ keyword.other.builtin.tcl
#         ^^^^ variable.parameter.tcl
#             ^ - meta.substitution.tcl
#              ^^^^^^^^^^^^^^^^^^^^^^^^ meta.substitution.tcl

    after\
#   ^^^^^ keyword.other.builtin.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    $event\
#   ^^^^^^ variable.other.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    $id
#   ^^^ variable.function.tcl

    after [expr 1000 * 60] puts "test"; # comment
#   ^^^^^ keyword.other.builtin.tcl
#         ^^^^^^^^^^^^^^^^ meta.substitution.tcl
#                         ^ - meta.substitution - meta.script
#                          ^^^^ support.function.builtin.tcl
#                               ^^^^^^ string.quoted.double.tcl
#                                     ^ punctuation.terminator.command.tcl
#                                       ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

##############################################################################
# array commands
##############################################################################

    array ; array
#   ^^^^^^ meta.statement.array.tcl
#         ^ - meta.array
#           ^^^^^^ meta.statement.array.tcl
#   ^^^^^ keyword.other.builtin.tcl
#         ^ punctuation.terminator.command.tcl
#           ^^^^^ keyword.other.builtin.tcl

    array 1 2 3
#   ^^^^^^^^^^^^ meta.statement.array.tcl
#   ^^^^^ keyword.other.builtin.tcl
#         ^ constant.numeric.integer.tcl
#           ^ constant.numeric.integer.tcl
#             ^ constant.numeric.integer.tcl

    array foo bar baz[incr x]
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.array.tcl
#   ^^^^^ keyword.other.builtin.tcl
#                    ^^^^^^^^ meta.substitution.tcl
    array\
#   ^^^^^^^ meta.statement.array.tcl
#   ^^^^^ keyword.other.builtin.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    foo\
#^^^^^^^^ meta.statement.array.tcl
#      ^ punctuation.separator.continuation.newline.tcl
    bar\
#^^^^^^^^ meta.statement.array.tcl
#      ^ punctuation.separator.continuation.newline.tcl
    baz[incr\
#^^^^^^^^^^^^^ meta.statement.array.tcl
#      ^ punctuation.section.substitution.begin.tcl
#      ^^^^^^^ meta.substitution.tcl
#       ^^^^ keyword.other.builtin.tcl
#           ^ punctuation.separator.continuation.newline.tcl
    x\
#^^^^^^ meta.statement.array.tcl meta.substitution.tcl
    ]
#^^^^^ meta.statement.array.tcl
#^^^^ meta.substitution.tcl
#   ^ punctuation.section.substitution.end.tcl

    array exists foo illegal; # comment
#   ^^^^^ keyword.other.builtin.tcl
#         ^^^^^^ variable.function.tcl
#                ^^^ variable.other.tcl
#                    ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#                           ^ punctuation.terminator.command.tcl
#                             ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    array get foo "pa?[A-z]ttern" illegal; # comment
#   ^^^^^ keyword.other.builtin.tcl
#         ^^^ variable.function.tcl
#             ^^^ variable.other.tcl
#                 ^ punctuation.definition.string.begin.tcl
#                 ^^^^^^^^^^^^^^^ string.quoted.double.tcl
#                    ^ constant.other.placeholder.tcl
#                     ^^^^^ meta.bracket.tcl constant.other.placeholder.tcl
#                               ^ punctuation.definition.string.end.tcl
#                                ^ - string
#                                 ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#                                        ^ punctuation.terminator.command.tcl
#                                          ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    array set foo [objectGetField -oid $cpeoid -fieldname parameters]
#   ^^^^^ keyword.other.builtin.tcl
#         ^^^ variable.function.tcl
#             ^^^ variable.other.tcl
#                 ^ punctuation.section.substitution.begin.tcl
#                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.substitution.tcl
#                                                                   ^ punctuation.section.substitution.end.tcl

    array names foo "pa?[A-z]ttern" illegal; # comment
#   ^^^^^ keyword.other.builtin.tcl
#        ^ - keyword - variable
#         ^^^^^ variable.function.tcl
#              ^ - variable
#               ^^^ variable.other.tcl
#                  ^ - variable - string
#                   ^ punctuation.definition.string.begin.tcl
#                   ^^^^^^^^^^^^^^^ string.quoted.double.tcl
#                      ^ - constant.other.placeholder.tcl
#                       ^^^^^ meta.substitution.tcl
#                                 ^ punctuation.definition.string.end.tcl
#                                  ^ - string
#                                   ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#                                          ^ punctuation.terminator.command.tcl
#                                            ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    array names foo -exact "pa?[A-z]ttern" illegal; # comment
#   ^^^^^ keyword.other.builtin.tcl
#        ^ - keyword - variable
#         ^^^^^ variable.function.tcl
#              ^ - variable
#               ^^^ variable.other.tcl
#                  ^ - variable
#                   ^^^^^^ variable.parameter.tcl
#                         ^ - variable - string
#                          ^ punctuation.definition.string.begin.tcl
#                          ^^^^^^^^^^^^^^^ string.quoted.double.tcl
#                             ^ - constant.other.placeholder.tcl
#                              ^^^^^ meta.substitution.tcl
#                                        ^ punctuation.definition.string.end.tcl
#                                         ^ - string
#                                          ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#                                                 ^ punctuation.terminator.command.tcl
#                                                   ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    array names foo -glob "pa?[A-z]ttern" illegal; # comment
#   ^^^^^ keyword.other.builtin.tcl
#        ^ - keyword - variable
#         ^^^^^ variable.function.tcl
#              ^ - variable
#               ^^^ variable.other.tcl
#                  ^ - variable
#                   ^^^^^ variable.parameter.tcl
#                        ^ - variable - string
#                         ^ punctuation.definition.string.begin.tcl
#                         ^^^^^^^^^^^^^^^ string.quoted.double.tcl
#                            ^ constant.other.placeholder.tcl
#                             ^^^^^ meta.bracket.tcl constant.other.placeholder.tcl
#                                       ^ punctuation.definition.string.end.tcl
#                                        ^ - string
#                                         ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#                                                ^ punctuation.terminator.command.tcl
#                                                  ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    array names foo -regexp "pa?[A-z]ttern" illegal; # comment
#   ^^^^^ keyword.other.builtin.tcl
#        ^ - keyword - variable
#         ^^^^^ variable.function.tcl
#              ^ - variable
#               ^^^ variable.other.tcl
#                  ^ - variable
#                   ^^^^^^^ variable.parameter.tcl
#                          ^ - variable - string
#                           ^ punctuation.definition.string.begin.tcl
#                           ^^^^^^^^^^^^^^^ string.quoted.double.tcl string.regexp.tcl
#                              ^ - constant.other.placeholder.tcl
#                               ^^^^^ meta.bracket.tcl
#                                         ^ punctuation.definition.string.end.tcl
#                                          ^ - string
#                                           ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#                                                  ^ punctuation.terminator.command.tcl
#                                                    ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    array names foo -inval "pa?[A-z]ttern" illegal; # comment
#   ^^^^^ keyword.other.builtin.tcl
#        ^ - keyword - variable
#         ^^^^^ variable.function.tcl
#              ^ - variable
#               ^^^ variable.other.tcl
#                  ^ - variable
#                   ^^^^^^ invalid.illegal.parameter.tcl
#                         ^ - variable - string
#                          ^ punctuation.definition.string.begin.tcl
#                          ^^^^^^^^^^^^^^^ string.quoted.double.tcl
#                             ^ - constant.other.placeholder.tcl
#                              ^^^^^ meta.substitution.tcl
#                                        ^ punctuation.definition.string.end.tcl
#                                         ^ - string
#                                          ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#                                                 ^ punctuation.terminator.command.tcl
#                                                   ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    array\
#   ^^^^^ keyword.other.builtin.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    names\
#   ^^^^^ variable.function.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    foo\
#   ^^^ variable.other.tcl
#      ^ punctuation.separator.continuation.newline.tcl
    -glob\
#   ^^^^^ variable.parameter.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    "pa?[A-z]ttern"
#  ^ - variable - string
#   ^ punctuation.definition.string.begin.tcl
#   ^^^^^^^^^^^^^^^ string.quoted.double.tcl
#      ^ constant.other.placeholder.tcl
#       ^^^^^ meta.bracket.tcl constant.other.placeholder.tcl
#                 ^ punctuation.definition.string.end.tcl
#                  ^ - string

    array \
#   ^^^^^ keyword.other.builtin.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    names \
#   ^^^^^ variable.function.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    foo \
#   ^^^ variable.other.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    -glob \
#   ^^^^^ variable.parameter.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    "pa?[A-z]ttern"
#  ^ - variable - string
#   ^ punctuation.definition.string.begin.tcl
#   ^^^^^^^^^^^^^^^ string.quoted.double.tcl
#      ^ constant.other.placeholder.tcl
#       ^^^^^ meta.bracket.tcl constant.other.placeholder.tcl
#                 ^ punctuation.definition.string.end.tcl
#                  ^ - string

    array set bits {
#                  ^ meta.statement.array.tcl meta.braces.tcl punctuation.section.braces.begin.tcl
        0 0000 1
#       ^ constant.numeric.integer.tcl
#         ^^^^ constant.numeric.integer.tcl
#              ^ constant.numeric.integer.tcl
        8 0001 9
#       ^ constant.numeric.integer.tcl
#         ^^^^ constant.numeric.integer.tcl
#              ^ constant.numeric.integer.tcl
    }
#   ^ meta.statement.array.tcl meta.braces.tcl punctuation.section.braces.end.tcl

    array unset foo "pa?[A-z]ttern"
#                      ^^^^^^ constant.other.placeholder.tcl

    array unset foo {pa?[A-z]ttern}
#                      ^^^^^^ constant.other.placeholder.tcl

##############################################################################
# coroutine tests
##############################################################################

    coroutine name func $arg
#   ^^^^^^^^^ keyword.other.builtin.tcl
#             ^^^^ entity.name.function.tcl
#                  ^^^^ variable.function.tcl
#                       ^^^^ variable.other.tcl

    coroutine\
#   ^^^^^^^^^ keyword.other.builtin.tcl
#            ^ punctuation.separator.continuation.newline.tcl
    name\
#   ^^^^ entity.name.function.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    func\
#   ^^^^ variable.function.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    $arg
#   ^^^^ variable.other.tcl

    coroutine [concat "na" "me"] puts $arg
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.coroutine.tcl
#             ^^^^^^^^^^^^^^^^^^  meta.substitution.tcl
#   ^^^^^^^^^ keyword.other.builtin.tcl
#                                ^^^^ support.function.builtin.tcl
#                                     ^^^^ variable.other.tcl

    coroutine [concat "na" "me"] {
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.coroutine.tcl
#             ^^^^^^^^^^^^^^^^^^  meta.substitution.tcl
#                                ^^ meta.braces.tcl string.quoted.brace.tcl
#                                ^ punctuation.section.braces.begin.tcl
#   ^^^^^^^^^ keyword.other.builtin.tcl
        func $arg
#
#       ^^^^ - variable.function - support.function.builtin
#            ^^^^ - variable
    }
#<- meta.statement.coroutine.tcl meta.braces.tcl
#   ^ meta.statement.coroutine.tcl meta.braces.tcl string.quoted.brace.tcl punctuation.section.braces.end.tcl

##############################################################################
# eval tests
##############################################################################

    eval $script puts "foo"
#   ^^^^ meta.statement.eval.tcl
#       ^^^^^^^^^^^^^^^^^^^^ meta.statement.eval.tcl
#   ^^^^ keyword.other.builtin.tcl
#        ^^^^^^^ variable.function.tcl
#                ^^^^ - keyword
#                     ^^^^^ string.quoted.double.tcl

    eval {puts} "foo"
#   ^^^^ meta.statement.eval.tcl
#       ^^^^^^^^^^^^^^ meta.statement.eval.tcl
#   ^^^^ keyword.other.builtin.tcl
#        ^^^^^^ meta.braces.tcl string.quoted.brace.tcl
#               ^^^^^ string.quoted.double.tcl

    eval {
#   ^^^^^^^ meta.statement.eval.tcl
#   ^^^^ keyword.other.builtin.tcl
#        ^ punctuation.section.braces.begin.tcl
#        ^^ meta.braces.tcl string.quoted.brace.tcl
        puts
#       ^^^^ meta.braces.tcl string.quoted.brace.tcl
    } "foo"
#<- meta.statement.eval.tcl meta.braces.tcl string.quoted.brace.tcl
#^^^^ meta.statement.eval.tcl meta.braces.tcl string.quoted.brace.tcl
#   ^ punctuation.section.braces.end.tcl
#    ^ meta.statement.eval.tcl - meta.braces
#     ^^^^^ string.quoted.double.tcl

##############################################################################
# expr tests
##############################################################################

    expr
#  ^ - meta.statement.expr
#   ^^^^^ meta.statement.expr.tcl
#   ^^^^ keyword.other.builtin.tcl

    expr eq ne in ni == != <= >= < >
#        ^^ keyword.operator.relational.tcl
#           ^^ keyword.operator.relational.tcl
#              ^^ keyword.operator.relational.tcl
#                 ^^ keyword.operator.relational.tcl
#                    ^^ keyword.operator.relational.tcl
#                       ^^ keyword.operator.relational.tcl
#                          ^^ keyword.operator.relational.tcl
#                             ^^ keyword.operator.relational.tcl
#                                ^ keyword.operator.relational.tcl
#                                  ^ keyword.operator.relational.tcl

    expr && || !
#        ^^ keyword.operator.logical.tcl
#           ^^ keyword.operator.logical.tcl
#              ^ keyword.operator.logical.tcl

    expr ^ | & ~
#        ^ keyword.operator.bitwise.tcl
#          ^ keyword.operator.bitwise.tcl
#            ^ keyword.operator.bitwise.tcl
#              ^ keyword.operator.bitwise.tcl

    expr 1 + 2 * $var ** 4 % 2 / 1
#  ^ - meta.statement.expr
#   ^^^^^^^^^^^^^^^^^^ meta.statement.expr.tcl
#   ^^^^ keyword.other.builtin.tcl
#        ^ constant.numeric.integer.tcl
#          ^ keyword.operator.arithmetic.tcl
#            ^ constant.numeric.integer.tcl
#              ^ keyword.operator.arithmetic.tcl
#                ^^^^ variable.other.tcl
#                     ^^ keyword.operator.arithmetic.tcl
#                        ^ constant.numeric.integer.tcl
#                          ^ keyword.operator.arithmetic.tcl
#                            ^ constant.numeric.integer.tcl
#                              ^ keyword.operator.arithmetic.tcl
#                                ^ constant.numeric.integer.tcl

    expr $var ? "true" : "false"
#        ^^^^ variable.other.tcl
#             ^ keyword.operator.ternary.tcl
#               ^^^^^^ string.quoted.double.tcl
#                      ^ keyword.operator.ternary.tcl
#                        ^^^^^^^ string.quoted.double.tcl

    expr {}
#  ^ - meta.statement.expr
#   ^^^^^^^^ meta.statement.expr.tcl
#   ^^^^ keyword.other.builtin.tcl
#        ^ meta.braces.tcl punctuation.section.braces.begin.tcl
#         ^ meta.braces.tcl punctuation.section.braces.end.tcl

    expr {
#  ^ - meta.statement.expr
#   ^^^^^^^ meta.statement.expr.tcl
#   ^^^^ keyword.other.builtin.tcl
#        ^ meta.braces.tcl punctuation.section.braces.begin.tcl
    } {
#^^^^^^^ meta.statement.expr.tcl
#^^^^ meta.braces.tcl
#   ^ punctuation.section.braces.end.tcl
#    ^ - meta.braces
#     ^^ meta.braces.tcl
#     ^ punctuation.section.braces.begin.tcl
    }
#^^^^^ meta.statement.expr.tcl
#^^^^ meta.braces.tcl
#   ^ punctuation.section.braces.end.tcl
#    ^ - meta.braces

    expr {
#  ^ - meta.statement.expr
#   ^^^^^^^ meta.statement.expr.tcl
#   ^^^^ keyword.other.builtin.tcl
#        ^ meta.braces.tcl punctuation.section.braces.begin.tcl
    list
#   ^^^^ - keyword - variable
    -
#^^^^^ meta.statement.expr.tcl meta.braces.tcl
#   ^ keyword.operator.arithmetic.tcl
    $var
#^^^^^^^^ meta.statement.expr.tcl meta.braces.tcl
#   ^^^^ variable.other.tcl
    +
#^^^^^ meta.statement.expr.tcl meta.braces.tcl
#   ^ keyword.operator.arithmetic.tcl
    [string "test"]
#^^^ meta.statement.expr.tcl meta.braces.tcl - meta.substitution
#   ^ punctuation.section.substitution.begin.tcl
#   ^^^^^^^^^^^^^^^ meta.statement.expr.tcl meta.braces.tcl meta.substitution.tcl
#    ^^^^^^ keyword.other.builtin.tcl
#           ^^^^^^ string.quoted.double.tcl
#                 ^ punctuation.section.substitution.end.tcl
#                  ^ meta.statement.expr.tcl meta.braces.tcl - meta.substitution
    *
#^^^^^ meta.statement.expr.tcl meta.braces.tcl
#   ^ keyword.operator.arithmetic.tcl
    10
#^^^^^^ meta.statement.expr.tcl meta.braces.tcl
#   ^^ constant.numeric.integer.tcl
    }
#^^^^^ meta.statement.expr.tcl
#^^^^ meta.braces.tcl
#   ^ punctuation.section.braces.end.tcl

##############################################################################
# file commands
##############################################################################

    file volumes illegal
#   ^^^^ keyword.other.builtin.tcl
#       ^ - keyword - variable
#        ^^^^^^^ variable.function.tcl
#               ^ - variable.function
#                ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    file atime "/var/pid.log" illegal
#   ^^^^ keyword.other.builtin.tcl
#       ^ - keyword - variable.function
#        ^^^^^ variable.function.tcl
#             ^ - string - variable
#              ^^^^^^^^^^^^^^ string.quoted.double.tcl
#                            ^ - string - invalid
#                             ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    file atime /var/pid.log illegal
#   ^^^^ keyword.other.builtin.tcl
#        ^^^^^ variable.function.tcl
#             ^ - string - variable
#              ^^^^^^^^^^^^ string.unquoted.tcl
#                          ^ - string - invalid
#                           ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    file copy /source/pid.log /target/pid.log illegal
#   ^^^^ keyword.other.builtin.tcl
#       ^ - keyword - variable.function
#        ^^^^ variable.function.tcl
#            ^ - string - variable
#             ^^^^^^^^^^^^^^^ string.unquoted.tcl
#                            ^ - string
#                             ^^^^^^^^^^^^^^^ string.unquoted.tcl
#                                             ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    file copy -force /source/pid.log /target/pid.log invalid
#   ^^^^ keyword.other.builtin.tcl
#       ^ - keyword - variable.function
#        ^^^^ variable.function.tcl
#             ^^^^^^ variable.parameter.tcl
#                   ^ - string - variable
#                    ^^^^^^^^^^^^^^^ string.unquoted.tcl
#                                   ^ - string
#                                    ^^^^^^^^^^^^^^^ string.unquoted.tcl
#                                                    ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    file copy -inval /source/pid.log /target/pid.log invalid
#   ^^^^ keyword.other.builtin.tcl
#       ^ - keyword - variable
#        ^^^^ variable.function.tcl
#             ^^^^^^ invalid.illegal.parameter.tcl
#                   ^ - string - variable
#                    ^^^^^^^^^^^^^^^ string.unquoted.tcl
#                                   ^ - string
#                                    ^^^^^^^^^^^^^^^ string.unquoted.tcl
#                                                    ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl


    file copy -force -- /source/pid.log /target/pid.log invalid
#   ^^^^ keyword.other.builtin.tcl
#       ^ - keyword - variable
#        ^^^^ variable.function.tcl
#             ^^^^^^ variable.parameter.tcl
#                   ^ - variable - punctuation
#                    ^^ punctuation.terminator.switches.tcl
#                      ^ - string - punctuation
#                       ^^^^^^^^^^^^^^^ string.unquoted.tcl
#                                      ^ - string
#                                       ^^^^^^^^^^^^^^^ string.unquoted.tcl
#                                                       ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    file copy -inval -- /source/pid.log /target/pid.log invalid
#   ^^^^ keyword.other.builtin.tcl
#       ^ - keyword - variable
#        ^^^^ variable.function.tcl
#             ^^^^^^ invalid.illegal.parameter.tcl
#                   ^ - variable - punctuation
#                    ^^ punctuation.terminator.switches.tcl
#                      ^ - string - punctuation
#                       ^^^^^^^^^^^^^^^ string.unquoted.tcl
#                                      ^ - string
#                                       ^^^^^^^^^^^^^^^ string.unquoted.tcl
#                                                       ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    file\
#   ^^^^ keyword.other.builtin.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    copy\
#   ^^^^ variable.function.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    -inval\
#   ^^^^^^ invalid.illegal.parameter.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    --\
#   ^^ punctuation.terminator.switches.tcl
#     ^ punctuation.separator.continuation.newline.tcl
    /source/pid.log\
#   ^^^^^^^^^^^^^^^ string.unquoted.tcl
#                  ^ punctuation.separator.continuation.newline.tcl
    /target/pid.log\
#   ^^^^^^^^^^^^^^^ string.unquoted.tcl
#                  ^ punctuation.separator.continuation.newline.tcl
    invalid
#   ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

# generic function highlighting without command specific syntax checks
    file unknown -unknown str
#   ^^^^ keyword.other.builtin.tcl
#        ^^^^^^^ variable.function.tcl
#                ^^^^^^^^ variable.parameter.tcl

##############################################################################
# for statement
##############################################################################

    # for loop execution
    for {set a 10} {$a < 20} {incr a} {
#   ^^^ keyword.control.flow.for.tcl
#       ^ punctuation.section.block.begin.tcl
#       ^^^^^^^^^^ meta.block.tcl
#        ^^^ keyword.other.builtin.tcl
#            ^ variable.other.tcl
#              ^^ constant.numeric.integer.tcl
#                ^ punctuation.section.block.end.tcl
#                 ^ - meta.block - meta.braces
#                  ^ punctuation.section.braces.begin.tcl
#                  ^^^^^^^^^ meta.braces.tcl
#                   ^^ variable.other.tcl
#                      ^ keyword.operator.relational.tcl
#                        ^^ constant.numeric.integer.tcl
#                          ^ punctuation.section.braces.end.tcl
#                           ^ - meta.block - meta.braces
#                            ^ punctuation.section.block.begin.tcl
#                            ^^^^^^^^ meta.block.tcl
#                             ^^^^ keyword.other.builtin.tcl
#                                  ^ variable.other.tcl
#                                   ^ punctuation.section.block.end.tcl
#                                    ^ - meta.block - meta.braces
#                                     ^ punctuation.section.block.begin.tcl
#                                     ^^ meta.block.tcl
#
       puts "value of a: $a"
    } illegal
#   ^ meta.block.tcl punctuation.section.block.end.tcl
#     ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

##############################################################################
# foreach statement
#
# SYNOPSIS
#   foreach varlist1 list1 ?varlist2 list2 ...? body
##############################################################################

    foreach
#   ^^^^^^^ keyword.control.flow.foreach.tcl
    foreach;foreach;#comment
#   ^^^^^^^ keyword.control.flow.foreach.tcl
#          ^ punctuation.terminator.command.tcl
#           ^^^^^^^ keyword.control.flow.foreach.tcl
#                  ^ punctuation.terminator.command.tcl
#                   ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    foreach i $list {puts $i};#comment
#   ^^^^^^^^^^^^^^^^ meta.statement.foreach.tcl
#                   ^^^^^^^^^ meta.statement.foreach.body.tcl meta.block.tcl
#   ^^^^^^^ keyword.control.flow.foreach.tcl
#           ^ variable.parameter.tcl
#             ^^^^^ variable.other.tcl
#                   ^ punctuation.section.block.begin.tcl
#                    ^^^^ support.function.builtin.tcl
#                         ^^ variable.other.tcl
#                            ^ punctuation.terminator.command.tcl
#                             ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    foreach\
#   ^^^^^^^^^ meta.statement.foreach.tcl
#   ^^^^^^^ keyword.control.flow.foreach.tcl
#          ^ punctuation.separator.continuation.newline.tcl
    i\
#^^^^^^ meta.statement.foreach.tcl
#   ^ variable.parameter.tcl
#    ^ punctuation.separator.continuation.newline.tcl
    $list\
#^^^^^^^^^^ meta.statement.foreach.tcl
#   ^^^^^ variable.other.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    {puts $i};#comment
#^^^ meta.statement.foreach.tcl
#   ^^^^^^^^^ meta.statement.foreach.body.tcl meta.block.tcl
#   ^ punctuation.section.block.begin.tcl
#    ^^^^ support.function.builtin.tcl
#         ^^ variable.other.tcl
#            ^ punctuation.terminator.command.tcl
#             ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    foreach i $list1 {j-k} $list2 {m {n-o} p} $list3 $body
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.foreach.tcl
#                                                    ^^^^^ meta.statement.foreach.body.tcl variable.other.tcl
#   ^^^^^^^ keyword.control.flow.foreach.tcl
#          ^ - keyword - variable
#           ^ variable.parameter.tcl
#            ^ - variable
#             ^^^^^^ variable.other.tcl
#                   ^ - variable
#                    ^ punctuation.definition.variable.begin.tcl
#                    ^^^^^ variable.parameter.tcl
#                        ^ punctuation.definition.variable.end.tcl
#                          ^^^^^^ variable.other.tcl
#                                 ^ punctuation.section.braces.tcl
#                                 ^^^ meta.braces.tcl
#                                  ^ meta.braces.tcl variable.parameter.tcl
#                                   ^ meta.braces.tcl - variable.parameter
#                                    ^ punctuation.definition.variable.begin.tcl
#                                    ^^^^^ meta.braces.tcl variable.parameter.tcl
#                                        ^ punctuation.definition.variable.end.tcl
#                                         ^ meta.braces.tcl - variable.parameter
#                                          ^ meta.braces.tcl variable.parameter.tcl
#                                           ^ meta.braces.tcl punctuation.section.braces.end.tcl
#                                            ^ - variable
#                                             ^^^^^^ variable.other.tcl
#                                                    ^^^^^ variable.other.tcl

    foreach {i j} {a b c d e f} {lappend x $i $j} illegal
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.foreach.tcl
#                               ^^^^^^^^^^^^^^^^^ meta.statement.foreach.body.tcl meta.block.tcl
#   ^^^^^^^ keyword.control.flow.foreach.tcl
#           ^ punctuation.section.braces.tcl
#           ^^^^^ meta.braces.tcl
#            ^ variable.parameter.tcl
#             ^ - variable
#              ^ variable.parameter.tcl
#               ^ punctuation.section.braces.end.tcl
#                ^ - meta.braces - meta.block - variable
#                 ^ punctuation.section.braces.begin.tcl
#                 ^^^^^^^^^^^^^ meta.braces.tcl
#                             ^ punctuation.section.braces.end.tcl
#                              ^ - meta.braces - meta.block - variable
#                               ^ punctuation.section.block.begin.tcl
#                                ^^^^^^^ support.function.builtin.tcl
#                                               ^ punctuation.section.block.end.tcl
#                                                 ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    foreach i {a b c} j {{d} 1 "f" [incr x]} {lappend x {$i $j}} illegal
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.foreach.tcl
#                                            ^^^^^^^^^^^^^^^^^^^ meta.statement.foreach.body.tcl meta.block.tcl
#   ^^^^^^^ keyword.control.flow.foreach.tcl
#           ^ variable.parameter.tcl
#            ^ - meta.braces - meta.block - variable
#             ^ punctuation.section.braces.begin.tcl
#             ^^^^^^^ meta.braces.tcl
#                   ^ punctuation.section.braces.end.tcl
#                    ^ - meta.braces - meta.block - variable
#                     ^ variable.parameter.tcl
#                      ^ - meta.braces - meta.block - variable
#                       ^ meta.braces.tcl punctuation.section.braces.begin.tcl
#                        ^ meta.braces.tcl meta.braces.tcl punctuation.section.braces.begin.tcl
#                          ^ meta.braces.tcl meta.braces.tcl punctuation.section.braces.end.tcl
#                           ^^^^^^^^^^^^^^^^ meta.braces.tcl
#                            ^ constant.numeric.integer.tcl
#                              ^^^ string.quoted.double.tcl
#                                  ^^^^^^^^ meta.substitution.tcl
#                                   ^^^^ keyword.other.builtin.tcl
#                                          ^ punctuation.section.braces.end.tcl
#                                           ^ - meta.braces - meta.block
#                                            ^ punctuation.section.block.begin.tcl
#                                             ^^^^^^^ support.function.builtin.tcl
#                                                              ^ punctuation.section.block.end.tcl
#                                                                ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    foreach {one_arg_opt_pattern} [list {-first\S*} {-second\S*} {-group\S*}] {
#           ^ punctuation.definition.variable.begin.tcl
#           ^^^^^^^^^^^^^^^^^^^^^ variable.parameter.tcl
#                               ^ punctuation.definition.variable.end.tcl
#                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.substitution.tcl
#                                                                             ^ meta.statement.foreach.body.tcl meta.block.tcl punctuation.section.block.begin.tcl
        regsub -- "${one_arg_opt_pattern}\\s+\\S+" $args {} args
#<- meta.statement.foreach.body.tcl meta.block.tcl
#       ^^^^^^ support.function.builtin.tcl
#              ^^ punctuation.terminator.switches.tcl
#                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ string.quoted.double
    }
#<- meta.statement.foreach.body.tcl meta.block.tcl
#   ^ meta.statement.foreach.body.tcl meta.block.tcl punctuation.section.block.end.tcl

    foreach i {
#   ^^^^^^^^^^^^ meta.statement.foreach.tcl
#   ^^^^^^^ keyword.control.flow.foreach.tcl
#           ^ variable.parameter.tcl
#             ^ punctuation.section.braces.begin.tcl
#             ^^ meta.braces.tcl
       GigabitEthernet1/18 \
#                      ^ - keyword.operator
#                          ^ punctuation.separator.continuation.newline.tcl
       Serial2/2/0.1/2/1/1:0
#                         ^ - keyword.operator
       GigabitEthernet9/24
    } {
#^^^^ meta.statement.foreach.tcl meta.braces.tcl
#   ^ punctuation.section.braces.end.tcl
#     ^ punctuation.section.block.begin.tcl
#     ^^ meta.statement.foreach.body.tcl meta.block.tcl
        set int [exec "show run inter $i | in Serial"]
        if {[regexp "Serial" $int ]} {
            puts "interface $i"
            puts "encap ppp"
        } else {
           puts "interface $i"
           puts "cdp enable"
           puts "Dampening"
           puts "no sh"
        }
    }

    set foo [Usage $opt]
    foreach [list x type($opt) usage($opt)] $foo break
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.foreach.tcl
#                                                ^^^^^ meta.statement.foreach.body.tcl
#   ^^^^^^^ keyword.control.flow.foreach.tcl

##############################################################################
# if-else tests
##############################################################################

    if true break elseif false continue else return
#   ^^ keyword.control.flow.if.tcl
#      ^^^^ constant.language.tcl
#           ^^^^^ keyword.control.flow.break.tcl
#                 ^^^^^^ keyword.control.flow.elseif.tcl
#                        ^^^^^ constant.language.tcl
#                              ^^^^^^^^ keyword.control.flow.continue.tcl
#                                       ^^^^ keyword.control.flow.else.tcl
#                                            ^^^^ keyword.control.flow.return.tcl

    if true then break elseif false then continue else return
#   ^^ keyword.control.flow.if.tcl
#      ^^^^ constant.language.tcl
#           ^^^^ keyword.control.flow.then.tcl
#                ^^^^^ keyword.control.flow.break.tcl
#                      ^^^^^^ keyword.control.flow.elseif.tcl
#                             ^^^^^ constant.language.tcl
#                                   ^^^^ keyword.control.flow.then.tcl
#                                        ^^^^^^^^ keyword.control.flow.continue.tcl
#                                                 ^^^^ keyword.control.flow.else.tcl
#                                                      ^^^^ keyword.control.flow.return.tcl

    if true {} elseif false {} {} illegal
#   ^^ keyword.control.flow.if.tcl
#      ^^^^ constant.language.tcl
#           ^ meta.block.tcl punctuation.section.block.begin.tcl
#            ^ meta.block.tcl punctuation.section.block.end.tcl
#              ^^^^^^ keyword.control.flow.elseif.tcl
#                     ^^^^^ constant.language.tcl
#                           ^ meta.block.tcl punctuation.section.block.begin.tcl
#                            ^ meta.block.tcl punctuation.section.block.end.tcl
#                              ^ meta.block.tcl punctuation.section.block.begin.tcl
#                               ^ meta.block.tcl punctuation.section.block.end.tcl
#                                 ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    if true then {} elseif false then {} else {} illegal; if false {cmd arg}
#   ^^ keyword.control.flow.if.tcl
#      ^^^^ constant.language.tcl
#           ^^^^ keyword.control.flow.then.tcl
#                ^ meta.block.tcl punctuation.section.block.begin.tcl
#                 ^ meta.block.tcl punctuation.section.block.end.tcl
#                   ^^^^^^ keyword.control.flow.elseif.tcl
#                          ^^^^^ constant.language.tcl
#                                ^^^^ keyword.control.flow.then.tcl
#                                     ^ meta.block.tcl punctuation.section.block.begin.tcl
#                                      ^ meta.block.tcl punctuation.section.block.end.tcl
#                                        ^^^^ keyword.control.flow.else.tcl
#                                             ^ meta.block.tcl punctuation.section.block.begin.tcl
#                                              ^ meta.block.tcl punctuation.section.block.end.tcl
#                                                ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#                                                       ^ punctuation.terminator.command.tcl
#                                                         ^^ keyword.control.flow.if.tcl
#                                                            ^^^^^ constant.language.tcl
#                                                                  ^ punctuation.section.block.begin.tcl
#                                                                  ^^^^^^^^^ meta.block.tcl
#                                                                          ^ punctuation.section.block.end.tcl

# check line continuation as word break without preceding whitespace
    if\
#   ^^ keyword.control.flow.if.tcl
#     ^ punctuation.separator.continuation.newline.tcl
    true\
#   ^^^^ constant.language.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    then\
#   ^^^^ keyword.control.flow.then.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    {cmd arg arg}\
#   ^ punctuation.section.block.begin.tcl
#   ^^^^^^^^^^^^^ meta.block.tcl
#    ^^^ variable.function.tcl
#               ^ punctuation.section.block.end.tcl
#                ^ punctuation.separator.continuation.newline.tcl
    elseif\
#   ^^^^^^ keyword.control.flow.elseif.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    false\
#   ^^^^^ constant.language.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    {}\
#   ^ meta.block.tcl punctuation.section.block.begin.tcl
#    ^ meta.block.tcl punctuation.section.block.end.tcl
#     ^ punctuation.separator.continuation.newline.tcl
    elseif\
#   ^^^^^^ keyword.control.flow.elseif.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    [puts\
#   ^ punctuation.section.substitution.begin.tcl
#   ^^^^^^^^ meta.substitution.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    "true"]\
# <- meta.substitution.tcl
#^^^^^^^^^^ meta.substitution.tcl
#   ^^^^^^ string.quoted.double.tcl
#         ^ punctuation.section.substitution.end.tcl
#          ^ punctuation.separator.continuation.newline.tcl
    {}\
#   ^ meta.block.tcl punctuation.section.block.begin.tcl
#    ^ meta.block.tcl punctuation.section.block.end.tcl
#     ^ punctuation.separator.continuation.newline.tcl
    else\
#   ^^^^ keyword.control.flow.else.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    {}
#   ^ meta.block.tcl punctuation.section.block.begin.tcl
#    ^ meta.block.tcl punctuation.section.block.end.tcl

# check line continuation with preceding whitespace
    if \
#   ^^ keyword.control.flow.if.tcl
#      ^ punctuation.separator.continuation.newline.tcl
    true \
#   ^^^^ constant.language.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    {cmd arg arg} \
#   ^ punctuation.section.block.begin.tcl
#   ^^^^^^^^^^^^^ meta.block.tcl
#    ^^^ variable.function.tcl
#               ^ punctuation.section.block.end.tcl
#                 ^ punctuation.separator.continuation.newline.tcl
    elseif \
#   ^^^^^^ keyword.control.flow.elseif.tcl
#          ^ punctuation.separator.continuation.newline.tcl
    false \
#   ^^^^^ constant.language.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    {} \
#   ^ meta.block.tcl punctuation.section.block.begin.tcl
#    ^ meta.block.tcl punctuation.section.block.end.tcl
#      ^ punctuation.separator.continuation.newline.tcl
    elseif \
#   ^^^^^^ keyword.control.flow.elseif.tcl
#          ^ punctuation.separator.continuation.newline.tcl
    [puts \
#   ^ punctuation.section.substitution.begin.tcl
#   ^^^^^^^^ meta.substitution.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    "true"] \
# <- meta.substitution.tcl
#^^^^^^^^^^ meta.substitution.tcl
#   ^^^^^^ string.quoted.double.tcl
#         ^ punctuation.section.substitution.end.tcl
#           ^ punctuation.separator.continuation.newline.tcl
    {} \
#   ^ meta.block.tcl punctuation.section.block.begin.tcl
#    ^ meta.block.tcl punctuation.section.block.end.tcl
#      ^ punctuation.separator.continuation.newline.tcl
    else \
#   ^^^^ keyword.control.flow.else.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    {}
#   ^ meta.block.tcl punctuation.section.block.begin.tcl
#    ^ meta.block.tcl punctuation.section.block.end.tcl

# Ensure else doesn't work outside of if command
    elseif true {}
#   ^^^^^^ invalid.illegal.unexpected.tcl
#          ^^^^ constant.language.tcl
#               ^ meta.block.tcl punctuation.section.block.begin.tcl
#                ^ meta.block.tcl punctuation.section.block.end.tcl
    elseif true {}
#   ^^^^^^ invalid.illegal.unexpected.tcl
#          ^^^^ constant.language.tcl
#               ^ meta.block.tcl punctuation.section.block.begin.tcl
#                ^ meta.block.tcl punctuation.section.block.end.tcl
    else {}
#   ^^^^ invalid.illegal.unexpected.tcl
#        ^ meta.block.tcl punctuation.section.block.begin.tcl
#         ^ meta.block.tcl punctuation.section.block.end.tcl
    else {}
#   ^^^^ invalid.illegal.unexpected.tcl
#        ^ meta.block.tcl punctuation.section.block.begin.tcl
#         ^ meta.block.tcl punctuation.section.block.end.tcl

    if {$arg eq [set x]} {
#   ^^ keyword.control.flow.if.tcl
#      ^ punctuation.section.braces.begin.tcl
#      ^^^^^^^^^^^^^^^^^ meta.braces.tcl
#       ^^^^ variable.other.tcl
#            ^^ keyword.operator.relational.tcl
#               ^^^^^^^ meta.substitution.tcl
#                      ^ punctuation.section.braces.end.tcl
#                        ^^ meta.block.tcl
#                        ^ punctuation.section.block.begin.tcl
        set var 0

        if {$var == 0} {
            puts "bar"
        } else {
            puts "baz"
        }

    } elseif [puts "true"] {

        puts "foo"
    } else {
        puts "bar"
    }

    if {[catch {ns::func -class interface \
#   ^^^ meta.statement.conditional.tcl
#      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.conditional.tcl
#   ^^ keyword.control.flow.if.tcl
#      ^ punctuation.section.braces.begin.tcl
#       ^ punctuation.section.substitution.begin.tcl
#        ^^^^^ keyword.control.flow.catch.tcl
#              ^ punctuation.section.block.begin.tcl
#               ^^^^^^^^ variable.function.tcl
#                 ^^ punctuation.accessor.double-colon.namespace.tcl
#                        ^^^^^^ variable.parameter.tcl
#                                         ^ punctuation.separator.continuation.newline.tcl
        -flags "statistics,interfaceautoprobe" \
#<- meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl meta.block.tcl
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl meta.block.tcl
#       ^^^^^^ variable.parameter.tcl
#              ^ punctuation.definition.string.begin.tcl
#              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ string.quoted.double.tcl
#                         ^ - punctuation
#                                            ^ punctuation.definition.string.end.tcl
#                                              ^ punctuation.separator.continuation.newline.tcl
        -name $aggrname -role $extra_role \
#<- meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl meta.block.tcl
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl meta.block.tcl
#       ^^^^^ variable.parameter.tcl
#             ^^^^^^^^^ variable.other.tcl
#                       ^^^^^ variable.parameter.tcl
#                             ^^^^^^^^^^^ variable.other.tcl
#                                         ^ punctuation.separator.continuation.newline.tcl
                        -parameters [array get params] \
#<- meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl meta.block.tcl
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl meta.block.tcl
#                       ^^^^^^^^^^^ variable.parameter.tcl
#                                   ^ punctuation.section.substitution.begin.tcl
#                                   ^^^^^^^^^^^^^^^^^^ meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl meta.block.tcl meta.substitution.tcl
#                                    ^^^^^ keyword.other.builtin.tcl
#                                                    ^ punctuation.section.substitution.end.tcl
#                                                      ^ punctuation.separator.continuation.newline.tcl
        -opaque [list "becs.editor" "ifrole.tcl"] \
#<- meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl meta.block.tcl
#^^^^^^^^^^^^^^^ meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl meta.block.tcl
#       ^^^^^^^ variable.parameter.tcl
#               ^ punctuation.section.substitution.begin.tcl
#               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl meta.block.tcl meta.substitution.tcl
#                ^^^^ keyword.other.builtin.tcl
#                     ^ punctuation.definition.string.begin.tcl
#                     ^^^^^^^^^^^^^ string.quoted.double.tcl
#                          ^ - punctuation
#                                 ^ punctuation.definition.string.end.tcl
#                                  ^ - string
#                                   ^ punctuation.definition.string.begin.tcl
#                                   ^^^^^^^^^^^^ string.quoted.double.tcl
#                                        ^ - punctuation
#                                              ^ punctuation.definition.string.end.tcl
#                                               ^ punctuation.section.substitution.end.tcl
#                                                 ^ punctuation.separator.continuation.newline.tcl
        -parentoid $aggr_attach_oid} err arg2]} {
#<- meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl meta.block.tcl
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl meta.block.tcl
#       ^^^^^^^^^^ variable.parameter.tcl
#                  ^^^^^^^^^^^^^^^^ variable.other.tcl
#                                  ^ punctuation.section.block.end.tcl
#                                   ^^^^^^^^^^ meta.statement.conditional.tcl meta.braces.tcl meta.substitution.tcl
#                                    ^^^ variable.other.tcl
#                                        ^^^^ variable.other.tcl
#                                            ^ punctuation.section.substitution.end.tcl
#                                             ^ meta.statement.conditional.tcl meta.braces.tcl punctuation.section.braces.end.tcl - meta.substitution
#                                              ^ meta.statement.conditional.tcl - meta.braces - meta.substitution - punctuation
#                                               ^ meta.statement.conditional.tcl meta.block.tcl punctuation.section.block.begin.tcl
        return "Creating aggregator interface $aggrname under element/management element-module OID $aggr_attach_oid: $err"
#<- meta.statement.conditional.tcl meta.block.tcl
    }
#   ^ meta.statement.conditional.tcl meta.block.tcl punctuation.section.block.end.tcl

##############################################################################
# incr commands
##############################################################################

    incr
#   ^^^^^ meta.statement.incr.tcl
#   ^^^^ keyword.other.builtin.tcl

    incr var
#   ^^^^^^^^^ meta.statement.incr.tcl
#   ^^^^ keyword.other.builtin.tcl
#        ^^^ variable.other.tcl

    incr var 2 illegal
#   ^^^^^^^^^^^^^^^^^^^ meta.statement.incr.tcl
#   ^^^^ keyword.other.builtin.tcl
#        ^^^ variable.other.tcl
#           ^ - variable - constant
#            ^ constant.numeric.integer.tcl - variable
#              ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

##############################################################################
# list commands
##############################################################################

    list
#   ^^^^^ meta.statement.list.tcl
#   ^^^^ keyword.other.builtin.tcl

    list;list 1;#comment
#   ^^^^ meta.statement.list.tcl keyword.other.builtin.tcl
#       ^ punctuation.terminator.command.tcl
#        ^^^^ meta.statement.list.tcl keyword.other.builtin.tcl
#             ^ meta.statement.list.tcl constant.numeric.integer.tcl
#              ^ punctuation.terminator.command.tcl
#               ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    list 1 3 str[sub] {str[nosub]} -> "quot"
#  ^ - meta.list
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.list.tcl
#   ^^^^ keyword.other.builtin.tcl
#        ^ constant.numeric.integer.tcl
#          ^ constant.numeric.integer.tcl
#               ^^^^^ meta.substitution.tcl
#                     ^^^^^^^^^^^^ meta.braces.tcl
#                         ^^^^^^^ meta.substitution.tcl
#                                     ^^^^^^ string.quoted.double.tcl

    list\
#  ^ - meta.list
#   ^^^^ meta.statement.list.tcl keyword.other.builtin.tcl
#       ^ meta.statement.list.tcl punctuation.separator.continuation.newline.tcl
    1\
#   ^ meta.statement.list.tcl constant.numeric.integer.tcl
#    ^ meta.statement.list.tcl punctuation.separator.continuation.newline.tcl
    3\
#   ^ meta.statement.list.tcl constant.numeric.integer.tcl
#    ^ meta.statement.list.tcl punctuation.separator.continuation.newline.tcl
    str[sub]\
#  ^^^^^^^^^^^ meta.statement.list.tcl
#      ^^^^^ meta.substitution.tcl
#           ^ punctuation.separator.continuation.newline.tcl
    {str[nosub]}\
#   ^^^^^^^^^^^^ meta.statement.list.tcl meta.braces.tcl
#       ^^^^^^^ meta.substitution.tcl
#               ^ meta.statement.list.tcl punctuation.separator.continuation.newline.tcl
    ->\
#   ^^^^ meta.statement.list.tcl
#     ^ punctuation.separator.continuation.newline.tcl
    "quot"
#   ^^^^^^^ meta.statement.list.tcl
#   ^^^^^^ string.quoted.double.tcl

    list {{1 2 3} {1 {2 str [incr x]} 3} {-1 -2 -3}}
#  ^ - meta.list
#   ^^^^^ meta.statement.list.tcl - meta.braces
#        ^ meta.statement.list.tcl meta.braces.tcl
#         ^^^^^^^ meta.statement.list.tcl meta.braces.tcl meta.braces.tcl
#                ^ meta.statement.list.tcl meta.braces.tcl
#                 ^^^ meta.statement.list.tcl meta.braces.tcl meta.braces.tcl
#                    ^^^^^^^^^^^^^^^^ meta.statement.list.tcl meta.braces.tcl meta.braces.tcl meta.braces.tcl
#                                    ^^^ meta.statement.list.tcl meta.braces.tcl meta.braces.tcl
#                                       ^ meta.statement.list.tcl meta.braces.tcl
#                                        ^^^^^^^^^^ meta.statement.list.tcl meta.braces.tcl meta.braces.tcl
#                                                  ^ meta.statement.list.tcl meta.braces.tcl
#                                                   ^ meta.statement.list.tcl
#   ^^^^ keyword.other.builtin.tcl
#        ^^ punctuation.section.braces.begin.tcl
#          ^ constant.numeric.integer.tcl
#            ^ constant.numeric.integer.tcl
#              ^ constant.numeric.integer.tcl
#               ^ punctuation.section.braces.end.tcl
#                 ^ punctuation.section.braces.begin.tcl
#                  ^ constant.numeric.integer.tcl
#                    ^ punctuation.section.braces.begin.tcl
#                     ^ constant.numeric.integer.tcl
#                           ^ punctuation.section.substitution.begin.tcl
#                            ^^^^ keyword.other.builtin.tcl
#                                  ^ punctuation.section.substitution.end.tcl
#                                   ^ punctuation.section.braces.end.tcl
#                                     ^ constant.numeric.integer.tcl
#                                      ^ punctuation.section.braces.end.tcl
#                                        ^ punctuation.section.braces.begin.tcl
#                                         ^^ constant.numeric.integer.tcl
#                                            ^^ constant.numeric.integer.tcl
#                                               ^^ constant.numeric.integer.tcl
#                                                 ^^ punctuation.section.braces.end.tcl

    list unquoted $words "without" \special {meaning}
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.list.tcl
#   ^^^^ keyword.other.builtin.tcl
#                 ^^^^^^ variable.other.tcl
#                        ^^^^^^^^^ string.quoted.double.tcl
#                                  ^^ constant.character.escape.other.tcl
#                                           ^ punctuation.section.braces.begin.tcl
#                                           ^^^^^^^^^ meta.braces.tcl
#                                                   ^ punctuation.section.braces.end.tcl

    lrange [split $res ","] 0 end-1
#   ^^^^^^ meta.function-call.tcl support.function.builtin.tcl
#         ^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call.parameters.tcl
#          ^^^^^^^^^^^^^^^^ meta.substitution.tcl
#                           ^ constant.numeric.integer.tcl
#                             ^^^ variable.language.list.end.tcl
#                                ^ keyword.operator.arithmetic.tcl
#                                 ^ constant.numeric.integer.tcl

##############################################################################
# namespace tests
##############################################################################

    namespace
#   ^^^^^^^^^ keyword.other.builtin.tcl

    namespace children A
#   ^^^^^^^^^ keyword.other.builtin.tcl
#             ^^^^^^^^ variable.function.tcl

    namespace which -command "name"
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.namespace.tcl
#   ^^^^^^^^^ keyword.other.builtin.tcl
#             ^^^^^ variable.function.tcl
#                   ^^^^^^^^  variable.parameter.tcl
#                            ^^^^^^ string.quoted.double.tcl

    namespace $other
#   ^^^^^^^^^^^^^^^^^ meta.namespace.tcl
#   ^^^^^^^^^ keyword.other.builtin.tcl
#             ^^^^^^ variable.other.tcl

    namespace \
#   ^^^^^^^^^ keyword.other.builtin.tcl
#             ^ punctuation.separator.continuation.newline.tcl
    eval \
#   ^^^^ variable.function.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    A \
#   ^ entity.name.namespace.tcl
#     ^ punctuation.separator.continuation.newline.tcl
    {
#^^^ meta.namespace.tcl - meta.block
#   ^^ meta.namespace.tcl meta.block.tcl
#   ^ punctuation.section.block.begin.tcl
    }
#^^^^ meta.namespace.tcl meta.block.tcl
#    ^ meta.namespace.tcl - meta.block.tcl
#   ^ punctuation.section.block.end.tcl

    namespace eval A {
#   ^^^^^^^^^^^^^^^^^^^ meta.namespace.tcl
#                    ^^ meta.block.tcl
#   ^^^^^^^^^ keyword.other.builtin.tcl
#             ^^^^ variable.function.tcl
#                  ^ entity.name.namespace.tcl
#                    ^ punctuation.section.block.begin.tcl
        namespace eval B \
#^^^^^^^ meta.namespace
#       ^^^^^^^^^^^^^^^^^^^ meta.namespace meta.namespace
#                    ^^ meta.block.tcl
#       ^^^^^^^^^ keyword.other.builtin.tcl
#                 ^^^^ variable.function.tcl
#                      ^ entity.name.namespace.tcl
#                        ^ punctuation.separator.continuation.newline
        {
#<- meta.namespace.tcl meta.namespace.tcl
#       ^ punctuation.section.block.begin.tcl
            namespace upvar $var
#           ^^^^^^^^^ keyword.other.builtin.tcl
#                     ^^^^^ storage.type.tcl
#                           ^^^^ variable.other.tcl
            namespace forget ns::var
#           ^^^^^^^^^ keyword.other.builtin.tcl
#                     ^^^^^^ variable.function.tcl

            proc A {

            }

            proc [proc A {}] {

            }

        }
    }

##############################################################################
# proc tests
##############################################################################

    proc
#   ^^^^ meta.function.tcl keyword.declaration.proc.tcl

    proc name
#  ^ - meta.function
#   ^^^^^^^^^^ meta.function.tcl
#   ^^^^ keyword.declaration.proc.tcl
#        ^^^^ entity.name.function.tcl
#            ^ - variable
    proc $name
#  ^ - meta.function
#   ^^^^^^^^^^ meta.function.tcl
#   ^^^^ keyword.declaration.proc.tcl
#        ^^^^^ variable.other.tcl
#             ^ - variable

    proc name args
#  ^ - meta.function
#   ^^^^^^^^^^^^^^^ meta.function.tcl
#             ^^^^ meta.function.parameters.tcl
#   ^^^^ keyword.declaration.proc.tcl
#        ^^^^ entity.name.function.tcl
#            ^ - variable
#             ^^^^ variable.parameter.tcl
#                 ^ - variable

    proc $name args
#  ^ - meta.function
#   ^^^^^^^^^^^^^^^ meta.function.tcl
#              ^^^^ meta.function.parameters.tcl
#   ^^^^ keyword.declaration.proc.tcl
#        ^^^^^ variable.other.tcl
#             ^ - variable
#              ^^^^ variable.parameter.tcl
#                  ^ - variable

    proc [expr name] args
#  ^ - meta.function
#   ^^^^^^^^^^^^^^^^^^^^^ meta.function.tcl
#                    ^^^^ meta.function.parameters.tcl
#   ^^^^ keyword.declaration.proc.tcl
#        ^^^^^^^^^^^ meta.substitution.tcl
#                   ^ - variable
#                    ^^^^ variable.parameter.tcl
#                        ^ - variable

    proc name args $body
#  ^ - meta.function
#   ^^^^^^^^^^^^^^^^^^^^^ meta.function.tcl
#             ^^^^ meta.function.parameters.tcl
#   ^^^^ keyword.declaration.proc.tcl
#        ^^^^ entity.name.function.tcl
#             ^^^^ variable.parameter.tcl
#                 ^ - variable
#                  ^^^^^ variable.other.tcl
#                       ^ - variable

    proc\
#  ^ - meta.function
#   ^^^^^^ meta.function.tcl
#   ^^^^ keyword.declaration.proc.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    name\
#^^^^^^^^^ meta.function.tcl
#   ^^^^ entity.name.function.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    args\
#^^^^^^^^^ meta.function.tcl
#   ^^^^ meta.function.parameters.tcl variable.parameter.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    $body
#^^^^^^^^ meta.function.tcl
#   ^^^^^ variable.other.tcl
#        ^ - variable

# If name includes any namespace qualifiers, the procedure is created in the specified namespace
    proc ns::name args $body
#  ^ - meta.function
#   ^^^^^^^^^^^^^^^^^^^^^^^^^ meta.function.tcl
#        ^^^^^^^^ entity.name.function.tcl
#          ^^ punctuation.accessor.double-colon.namespace.tcl
#                 ^^^^ meta.function.parameters.tcl
#                      ^^^^^ variable.other.tcl
#                           ^ - variable

# Args specifies the formal arguments to the procedure. It consists of a list,
# possibly empty, each of whose elements specifies one argument. Each argument
# specifier is also a list with either one or two fields. If there is only a
# single field in the specifier then it is the name of the argument; if there
# are two fields, then the first is the argument name and the second is its
# default value.
    proc name {} {}
#  ^ - meta.function
#   ^^^^^^^^^^ meta.function.tcl - meta.function.parameters
#   ^^^^ keyword.declaration.proc.tcl
#        ^^^^ entity.name.function.tcl
#             ^ punctuation.section.braces.begin.tcl
#             ^^ meta.function.parameters.tcl meta.braces.tcl
#              ^ punctuation.section.braces.end.tcl
#               ^^^ meta.function.tcl - meta.function.parameters
#                ^ punctuation.section.block.begin.tcl
#                ^^ meta.block.tcl
#                 ^ punctuation.section.block.end.tcl

    proc echo {{text "foo" invalid}} {puts $text}
#  ^ - meta.function
#   ^^^^^^^^^^ meta.function.tcl - meta.function.parameters - meta.braces
#             ^ meta.function.parameters.tcl meta.braces.tcl
#              ^^^^^^^^^^^^^^^^^^^^ meta.function.parameters.tcl meta.braces.tcl meta.braces.tcl
#                          ^^^^^^^ invalid.illegal.end-of-param-expected.tcl
#                                  ^ meta.function.parameters.tcl meta.braces.tcl
#                                   ^ meta.function.tcl - meta.function.parameters - meta.braces - meta.block
#                                    ^^^^^^^^^^^^ meta.block.tcl
#                                     ^ meta.function-call.tcl
#   ^^^^ keyword.declaration.proc.tcl
#        ^^^^ entity.name.function.tcl
#             ^^ punctuation.section.braces.begin.tcl
#               ^^^^ variable.parameter.tcl
#                    ^^^^^ string.quoted.double.tcl
#                                 ^^ punctuation.section.braces.end.tcl
#                                    ^ punctuation.section.block.begin.tcl
#                                     ^^^^ support.function.builtin.tcl
#                                          ^^^^^ variable.other.tcl
#                                               ^ punctuation.section.block.end.tcl

    proc\
#  ^ - meta.function
#   ^^^^^^ meta.function.tcl - meta.function.parameters - meta.braces
#   ^^^^ keyword.declaration.proc.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    echo\
#  ^^^^^^^ meta.function.tcl - meta.function.parameters - meta.braces
#   ^^^^ entity.name.function.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    {\
#  ^ meta.function.tcl - meta.function.parameters - meta.braces
#   ^ punctuation.section.braces.begin.tcl
#   ^^ meta.function.parameters.tcl meta.braces.tcl
#    ^ punctuation.separator.continuation.newline.tcl
        {\
#      ^ meta.function.parameters.tcl meta.braces.tcl
#       ^ punctuation.section.braces.begin.tcl
#       ^^ meta.function.parameters.tcl meta.braces.tcl meta.braces.tcl
#        ^ punctuation.separator.continuation.newline.tcl
            text\
#           ^^^^ variable.parameter.tcl
#               ^ punctuation.separator.continuation.newline.tcl
            "foo"\
#           ^^^^^ string.quoted.double.tcl
#                ^ punctuation.separator.continuation.newline.tcl
            invalid\
#           ^^^^^^^ invalid.illegal.end-of-param-expected.tcl
#                  ^ punctuation.separator.continuation.newline.tcl
        }\
#      ^ meta.function.parameters.tcl meta.braces.tcl meta.braces.tcl - punctuation
#       ^ meta.function.parameters.tcl meta.braces.tcl meta.braces.tcl punctuation.section.braces.end.tcl
#        ^ meta.function.parameters.tcl meta.braces.tcl punctuation.separator.continuation.newline.tcl
    }\
#  ^ meta.function.parameters.tcl meta.braces.tcl - punctuation
#   ^ meta.function.parameters.tcl meta.braces.tcl punctuation.section.braces.end.tcl
#    ^ meta.function.tcl punctuation.separator.continuation.newline.tcl
    {
#   ^ meta.function.tcl meta.block.tcl punctuation.section.block.begin.tcl
        upvar var $up
#       ^^^^^^^^^^^^^^ meta.function.tcl meta.block.tcl meta.definition.variable.tcl
#       ^^^^^ storage.type.tcl
#             ^^^ variable.other.tcl
#                 ^^^ variable.other.tcl
        puts\
#       ^^^^ meta.function.tcl meta.block.tcl meta.function-call.tcl support.function.builtin.tcl
#           ^ meta.function.tcl meta.block.tcl meta.function-call.parameters.tcl punctuation.separator.continuation.newline.tcl
        $text
#       ^^^^^ meta.function.tcl meta.block.tcl meta.function-call.parameters.tcl variable.other.tcl
    }
#   ^ meta.function.tcl meta.block.tcl punctuation.section.block.end.tcl

    proc mult {par {multiplier 2} {verify AcceptAll}} {
#  ^ - meta.function
#   ^^^^^^^^^^ meta.function.tcl - meta.function.parameters - meta.braces
#             ^^^^^ meta.function.parameters.tcl meta.braces.tcl
#                  ^^^^^^^^^^^^^^ meta.function.parameters.tcl meta.braces.tcl meta.braces.tcl
#                                ^ meta.function.parameters.tcl meta.braces.tcl
#                                  ^^^^^^ variable.parameter.tcl
#                                         ^^^^^^^^^ - invalid.illegal
#                                                    ^ meta.function.tcl - meta.function.parameters - meta.braces
#                                                     ^ meta.function.tcl meta.block.tcl punctuation.section.block.begin.tcl
#             ^ punctuation.section.braces.begin.tcl
#              ^^^ variable.parameter.tcl
#                  ^ punctuation.section.braces.begin.tcl
#                   ^^^^^^^^^^ variable.parameter.tcl
#                              ^ constant.numeric.integer.tcl
#                                                  ^^ punctuation.section.braces.end.tcl
#
        upvar 1 $par var
#<- meta.function.tcl meta.block.tcl
#       ^^^^^ meta.function.tcl meta.block.tcl meta.definition.variable.tcl storage.type.tcl
        set var [expr {$var * $multiplier}]
    } invalid
#<- meta.function.tcl meta.block.tcl
#^^^^ meta.function.tcl meta.block.tcl
#   ^ punctuation.section.block.end.tcl
#    ^^^^^^^^^ meta.function.tcl - meta.block.tcl
#     ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    proc $procName {clockval timezone} "
#                                      ^ meta.function.tcl string.quoted.double.tcl punctuation.definition.string.begin.tcl
        $preFormatCode
#       ^^^^^^^^^^^^^^ meta.function.tcl string.quoted.double.tcl variable.other.tcl
        return \[::format [list $formatString] $substituents\]
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.function.tcl string.quoted.double.tcl
#       ^^^^^^ - keyword
#              ^^ constant.character.escape.other.tcl
#                         ^^^^^^^^^^^^^^^^^^^^ meta.substitution.tcl
#                                              ^^^^^^^^^^^^^ variable.other.tcl
    " illegal
#   ^ meta.function.tcl string.quoted.double.tcl punctuation.definition.string.end.tcl
#    ^ meta.function.tcl - string - punctuation
#     ^^^^^^^ meta.function.tcl invalid.illegal.end-of-cmd-expected.tcl

##############################################################################
# regexp commands
##############################################################################

    regexp -start 5 {\mfoo(?!bar\M)(\w*)} $string -> restOfWord
#   ^^^^^^ support.function.builtin.tcl
#          ^^^^^^ variable.parameter.tcl
#                 ^ constant.numeric.integer.tcl
#                   ^ punctuation.section.braces.begin.tcl
#                   ^^^^^^^^^^^^^^^^^^^^^ meta.braces.tcl string.quoted.brace.tcl string.regexp.tcl
#                                       ^ punctuation.section.braces.end.tcl
#                                         ^^^^^^^ variable.other.tcl
#                                                 ^^ variable.other
    regexp -invalid {% pattern %}
#   ^^^^^^ support.function.builtin.tcl
#          ^^^^^^^^ invalid.illegal.parameter.tcl
#                   ^^^^^^^^^^^^^ meta.braces.tcl string.quoted.brace.tcl string.regexp.tcl

# https://github.com/sublimehq/Packages/issues/779
    regexp -inline -all -- {%[a-zA-Z_]*%} "whatever"
#   ^^^^^^ support.function.builtin.tcl
#          ^^^^^^^ variable.parameter.tcl
#                 ^ - punctuation - variable
#                  ^^^^ variable.parameter.tcl
#                      ^ - punctuation - variable
#                       ^^ punctuation.terminator.switches.tcl
#                         ^ - meta.braces - punctuation - string
#                          ^ punctuation.section.braces.begin.tcl
#                          ^^^^^^^^^^^^^^ meta.braces.tcl string.quoted.brace.tcl string.regexp.tcl
#                                       ^ punctuation.section.braces.end.tcl
#                                        ^ - meta.braces - string
#                                         ^^^^^^^^^^ string.quoted.double.tcl
    regexp\
#   ^^^^^^ support.function.builtin.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    -inline\
#   ^^^^^^^ variable.parameter.tcl
#          ^ punctuation.separator.continuation.newline.tcl
    -all\
#   ^^^^ variable.parameter.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    --\
#   ^^ punctuation.terminator.switches.tcl
#     ^ punctuation.separator.continuation.newline.tcl
    {%[a-zA-Z_]*%}\
#  ^ - meta.braces - punctuation - string
#   ^ punctuation.section.braces.begin.tcl
#   ^^^^^^^^^^^^^^ meta.braces.tcl string.quoted.brace.tcl string.regexp.tcl
#                ^ punctuation.section.braces.end.tcl
#                 ^ punctuation.separator.continuation.newline.tcl
    "whatever"
#  ^ - meta.braces - string
#   ^^^^^^^^^^ string.quoted.double.tcl

    regexp {instance="?([^" \t]+)"?} $counter matchedstring instance; # comment
#   ^^^^^^ support.function.builtin.tcl
#         ^ - keyword - meta.braces - string
#          ^ punctuation.section.braces.begin.tcl
#          ^^^^^^^^^^^^^^^^^^^^^^^^^ meta.braces.tcl
#           ^^^^^^^^^^^^^^^^^^^^^^^ string.regexp
#                                  ^ punctuation.section.braces.end.tcl
#                                   ^ - meta.braces - string
#                                    ^^^^^^^^ variable.other.tcl
#                                             ^^^^^^^^^^^^^ variable.other.tcl
#                                                           ^^^^^^^^ variable.other.tcl
#                                                                   ^ punctuation.terminator.command.tcl
#                                                                     ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    regsub
#   ^^^^^^ support.function.builtin.tcl

    regsub ; regexp;#
#   ^^^^^^ support.function.builtin.tcl
#          ^ punctuation.terminator.command.tcl
#            ^^^^^^ support.function.builtin.tcl
#                  ^ punctuation.terminator.command.tcl
#                   ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    regsub -all {"} $args {""}
#   ^^^^^^ support.function.builtin.tcl
#          ^^^^ variable.parameter.tcl
#              ^ - meta.braces - constant - string - variable
#               ^ punctuation.section.braces.begin.tcl
#               ^^^ meta.braces.tcl string.quoted.brace.tcl string.regexp.tcl
#                 ^ punctuation.section.braces.end.tcl
#                  ^ - meta.braces - string
#                   ^ variable.other.tcl punctuation.definition.variable.tcl
#                    ^^^^ variable.other.tcl
#                        ^ - meta.braces - string - variable
#                         ^ punctuation.section.braces.begin.tcl
#                         ^^^^ meta.braces.tcl string.quoted.brace.tcl string.regexp.tcl
#                            ^ punctuation.section.braces.end.tcl
#                             ^ - meta.braces - string

    regsub -start 5 -all -- -all\b[set var] $var
#   ^^^^^^ support.function.builtin.tcl
#          ^^^^^^ variable.parameter.tcl
#                 ^ constant.numeric.integer.tcl
#                   ^^^^ variable.parameter.tcl
#                        ^^ punctuation.terminator.switches.tcl
#                           ^^^^^^^^^^^^^^^ string.unquoted.tcl string.regexp.tcl
#                               ^^ constant.character.escape.other.tcl
#                                 ^^^^^^^^^ meta.substitution.tcl
#                                           ^^^^ variable.other.tcl

    regsub -all {[A-z]\d+na\/\b} $args {\\} varname illegal
#   ^^^^^^ support.function.builtin.tcl
#          ^^^^ variable.parameter.tcl
#               ^ punctuation.section.braces.begin.tcl
#               ^^^^^^^^^^^^^^^^ meta.braces.tcl
#                              ^ punctuation.section.braces.end.tcl
#                                ^^^^^ variable.other.tcl
#                                      ^ punctuation.section.braces.begin.tcl
#                                      ^^^^ meta.braces.tcl
#                                         ^ punctuation.section.braces.end.tcl
#                                           ^^^^^^^ variable.other.tcl
#                                                   ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    regsub\
#   ^^^^^^ support.function.builtin.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    -all\
#   ^^^^ variable.parameter.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    {[A-z]\d+na\/\b}\
#   ^ punctuation.section.braces.begin.tcl
#   ^^^^^^^^^^^^^^^^ meta.braces.tcl
#                  ^ punctuation.section.braces.end.tcl
#                   ^ punctuation.separator.continuation.newline.tcl
    $args\
#   ^^^^^ variable.other.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    {\\}\
#   ^ punctuation.section.braces.begin.tcl
#   ^^^^ meta.braces.tcl
#      ^ punctuation.section.braces.end.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    varname\
#   ^^^^^^^ variable.other.tcl
#          ^ punctuation.separator.continuation.newline.tcl
    illegal
#   ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl

    regsub -all "[A-z]\d+na\/\b" $args "\\" args
#   ^^^^^^ support.function.builtin.tcl
#          ^^^^ variable.parameter.tcl
#               ^ punctuation.definition.string.begin.tcl
#               ^^^^^^^^^^^^^^^^ string.quoted.double.tcl string.regexp.tcl
#                              ^ punctuation.definition.string.end.tcl
#                                ^^^^^ variable.other.tcl
#                                      ^ punctuation.definition.string.begin.tcl
#                                      ^^^^ string.quoted.double.tcl string.regexp
#                                         ^ punctuation.definition.string.end.tcl

    regsub -- "${one_arg_opt_pattern}\\s+\\S+" $args {} args
#   ^^^^^^ support.function.builtin.tcl
#          ^^ punctuation.terminator.switches.tcl
#             ^ string.quoted.double.tcl string.regexp.tcl punctuation.definition.string.begin.tcl
#                                              ^ variable.other.tcl punctuation.definition.variable.tcl

##############################################################################
# set commands
##############################################################################

    set var "val"
#   ^^^ keyword.other.builtin.tcl
#      ^ - keyword - variable
#       ^^^ variable.other.tcl
#          ^ - variable - string
#           ^^^^^ string.quoted.double.tcl
#                ^ - string

    set\
#   ^^^ keyword.other.builtin.tcl
#      ^ punctuation.separator.continuation.newline.tcl
    var\
#   ^^^ variable.other.tcl
#      ^ punctuation.separator.continuation.newline.tcl
    "val"
#   ^^^^^ string.quoted.double.tcl
#

    set var {val}
#   ^^^ keyword.other.builtin.tcl
#      ^ - keyword - variable
#       ^^^ variable.other.tcl
#           ^^^^^ string.quoted.brace.tcl
#

    set {var1 var2} [list "val1" {val2}]
#   ^^^ keyword.other.builtin.tcl
#      ^ - keyword - variable
#       ^ punctuation.section.braces.begin.tcl
#       ^^^^^^^^^^^ meta.braces.tcl
#        ^^^^ variable.other.tcl
#            ^ - variable
#             ^^^^ variable.other.tcl
#                 ^ punctuation.section.braces.end.tcl
#                  ^ - variable
#                   ^ punctuation.section.substitution.begin.tcl
#                   ^^^^^^^^^^^^^^^^^^^^ meta.substitution.tcl
#                    ^^^^ keyword.other.builtin.tcl
#                                      ^ punctuation.section.substitution.end.tcl

    set anAry(msg) "Hello, World!"
#   ^^^ keyword.other.builtin.tcl
#      ^ - keyword - variable
#       ^^^^^^^^^^ variable.other.tcl
#            ^ punctuation.section.parens.begin.tcl
#            ^^^^^ meta.parens.tcl
#                ^ punctuation.section.parens.end.tcl

    set vbl in[expr {rand() >= 0.5}]

##############################################################################
# string commands
##############################################################################

    string
#   ^^^^^^ keyword.other.builtin.tcl

    string ;string;#comment
#   ^^^^^^ keyword.other.builtin.tcl
#          ^ punctuation.terminator.command.tcl
#           ^^^^^^ keyword.other.builtin.tcl
#                 ^ punctuation.terminator.command.tcl
#                  ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    string compare $str1 $str2; string last $str3
#   ^^^^^^ keyword.other.builtin.tcl
#          ^^^^^^^ variable.function.tcl
#                  ^^^^^ variable.other.tcl
#                        ^^^^^ variable.other.tcl
#                             ^ punctuation.terminator.command.tcl
#                               ^^^^^^ keyword.other.builtin.tcl
#                                      ^^^^ variable.function.tcl
#                                           ^^^^^ variable.other.tcl

    string\
#   ^^^^^^ keyword.other.builtin.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    compare\
#   ^^^^^^^ variable.function.tcl
#          ^ punctuation.separator.continuation.newline.tcl
    $str1\
#   ^^^^^ variable.other.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    $str2
#   ^^^^^ variable.other.tcl

    string \
#   ^^^^^^ keyword.other.builtin.tcl
#          ^ punctuation.separator.continuation.newline.tcl
    compare \
#   ^^^^^^^ variable.function.tcl
#           ^ punctuation.separator.continuation.newline.tcl
    $str1 \
#   ^^^^^ variable.other.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    $str2
#   ^^^^^ variable.other.tcl

    string is ascii "my ascii"
#   ^^^^^^ keyword.other.builtin.tcl
#          ^^ variable.function.tcl
#             ^^^^^ storage.type.tcl
#                   ^^^^^^^^^^ string.quoted.double.tcl

    string\
#   ^^^^^^ keyword.other.builtin.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    is\
#   ^^ variable.function.tcl
#     ^ punctuation.separator.continuation.newline.tcl
    ascii\
#   ^^^^^ storage.type.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    "my ascii"
#   ^^^^^^^^^^ string.quoted.double.tcl

    string is $type "my ascii"
#   ^^^^^^ keyword.other.builtin.tcl
#          ^^ variable.function.tcl
#             ^^^^^ variable.other.tcl
#                   ^^^^^^^^^^ string.quoted.double.tcl

    string is inval "my ascii"
#   ^^^^^^ keyword.other.builtin.tcl
#          ^^ variable.function.tcl
#             ^^^^^ - storage.type.tcl
#                   ^^^^^^^^^^ string.quoted.double.tcl

    string inval $str
#   ^^^^^^ keyword.other.builtin.tcl
#          ^^^^^ - variable.function.tcl
#                ^^^^ variable.other.tcl

    string match "patt[-[\]_A-z]r?n" $str
#   ^^^^^^ keyword.other.builtin.tcl
#          ^^^^^ variable.function.tcl
#                ^ punctuation.definition.string.begin.tcl
#                ^^^^^^^^^^^^^^^^^^^ string.quoted.double.tcl
#                     ^ punctuation.section.bracket.begin.tcl
#                     ^^^^^^^^^^ meta.bracket.tcl constant.other.placeholder.tcl
#                      ^ - punctuation.separator
#                        ^^ constant.character.escape.tcl
#                            ^  punctuation.separator.sequence.tcl
#                              ^ punctuation.section.bracket.begin.tcl
#                                ^ constant.other.placeholder.tcl
#                                  ^ punctuation.definition.string.end.tcl
#                                    ^^^^ variable.other.tcl

    string\
#   ^^^^^^ keyword.other.builtin.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    match\
#  ^ - variable.function
#   ^^^^^ variable.function.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    -nocase\
#   ^^^^^^^ variable.parameter.tcl
#          ^ punctuation.separator.continuation.newline.tcl
    "patt[-[\]_A-z]r?n" $str
#   ^^^^^^^^^^^^^^^^^^^ string.quoted.double.tcl
#        ^ punctuation.section.bracket.begin.tcl
#        ^^^^^^^^^^ meta.bracket.tcl constant.other.placeholder.tcl
#         ^ - punctuation.separator
#           ^^ constant.character.escape.tcl
#               ^  punctuation.separator.sequence.tcl
#                 ^ punctuation.section.bracket.begin.tcl
#                   ^ constant.other.placeholder.tcl
#                     ^ punctuation.definition.string.end.tcl
#                       ^^^^ variable.other.tcl

    string \
#   ^^^^^^ keyword.other.builtin.tcl
#          ^ punctuation.separator.continuation.newline.tcl
    match \
#  ^ - variable.function
#   ^^^^^ variable.function.tcl
#        ^ - variable.function
#         ^ punctuation.separator.continuation.newline.tcl
    -nocase \
#   ^^^^^^^ variable.parameter.tcl
#           ^ punctuation.separator.continuation.newline.tcl
    "p\?a\*t\[t\]
#  ^ - string
#   ^ punctuation.definition.string.begin.tcl
#   ^^^^^^^^^^^^^^ string.quoted.double.tcl
#     ^^ constant.character.escape.other.tcl - constant.other.placeholder
#        ^^ constant.character.escape.other.tcl - constant.other.placeholder
#           ^^ constant.character.escape.other.tcl - punctuation
#              ^^ constant.character.escape.other.tcl - punctuation
    [_A-z]*r?n
#^^^^^^^^^^^^^^ string.quoted.double.tcl
#   ^ punctuation.section.bracket.begin.tcl
#        ^ punctuation.section.bracket.begin.tcl
#         ^ constant.other.placeholder.tcl
#           ^ constant.other.placeholder.tcl
    " $str
# <- string.quoted.double.tcl
#   ^ string.quoted.double.tcl punctuation.definition.string.end.tcl
#    ^ - string
#     ^^^^ variable.other.tcl

    string match -nocase {p\?a\*t\[t\][_A-z]*r?n} $str
#   ^^^^^^ keyword.other.builtin.tcl
#          ^^^^^ variable.function.tcl
#                ^^^^^^^ variable.parameter.tcl
#                        ^ punctuation.section.braces.begin.tcl
#                        ^^^^^^^^^^^^^^^^^^^^^^^^ meta.braces.tcl string.quoted.brace.tcl
#                          ^^ constant.character.escape.other.tcl - constant.other.placeholder
#                             ^^ constant.character.escape.other.tcl - constant.other.placeholder
#                                ^^ constant.character.escape.other.tcl - punctuation
#                                   ^^ constant.character.escape.other.tcl - punctuation
#                                     ^ punctuation.section.bracket.begin.tcl
#                                          ^ punctuation.section.bracket.begin.tcl
#                                           ^ constant.other.placeholder.tcl
#                                             ^ constant.other.placeholder.tcl
#                                               ^ punctuation.section.braces.end.tcl

    string match -invalid {pattern} $str
#   ^^^^^^ keyword.other.builtin.tcl
#          ^^^^^ variable.function.tcl
#                ^^^^^^^^ invalid.illegal.parameter.tcl
#                         ^^^^^^^^^ meta.braces.tcl string.quoted.brace.tcl
#                                   ^^^^ variable.other.tcl

    string wordstart "string" 4+2
#                             ^ constant.numeric.integer.tcl
#                              ^ keyword.operator.arithmetic.tcl
#                               ^ constant.numeric.integer.tcl

    string wordstart "string" end-2
#                             ^^^ variable.language.string.end.tcl
#                                ^ keyword.operator.arithmetic.tcl
#                                 ^ constant.numeric.integer.tcl

##############################################################################
# switch commands
##############################################################################

    switch
#   ^^^^^^ keyword.control.flow.switch.tcl

    switch; switch
#   ^^^^^^ keyword.control.flow.switch.tcl
#         ^ punctuation.terminator.command.tcl
#           ^^^^^^ keyword.control.flow.switch.tcl

    switch $var; switch
#   ^^^^^^ meta.statement.switch.tcl
#         ^ meta.statement.switch.options.tcl
#          ^^^^ meta.statement.switch.tcl
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^ variable.other.tcl
#              ^ punctuation.terminator.command.tcl
#                ^^^^^^ keyword.control.flow.switch.tcl

    switch $var match $body default $body
#   ^^^^^^ meta.statement.switch.tcl
#         ^ meta.statement.switch.options.tcl
#          ^^^^^ meta.statement.switch.tcl
#               ^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.statement.switch.body.tcl
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^ variable.other.tcl
#               ^^^^^ string.unquoted.tcl
#                     ^^^^^ variable.other.tcl
#                           ^^^^^^^ keyword.control.flow.default.tcl
#                                   ^^^^^ variable.other.tcl

    switch\
#   ^^^^^^ keyword.control.flow.switch.tcl
#         ^ punctuation.separator.continuation.newline.tcl
    $var\
#   ^^^^ variable.other.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    match\
#   ^^^^^ string.unquoted.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    $body\
#   ^^^^^ variable.other.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    default\
#   ^^^^^^^ keyword.control.flow.default.tcl
#          ^ punctuation.separator.continuation.newline.tcl
    $body
#   ^^^^^ variable.other.tcl

    switch $var match {} default {}
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^ variable.other.tcl
#               ^^^^^ string.unquoted.tcl
#                     ^ meta.block.tcl punctuation.section.block.begin.tcl
#                      ^ meta.block.tcl punctuation.section.block.end.tcl
#                        ^^^^^^^ keyword.control.flow.default.tcl
#                                ^ meta.block.tcl punctuation.section.block.begin.tcl
#                                 ^ meta.block.tcl punctuation.section.block.end.tcl

    switch $var {match {} default {}} #illegal; #comment
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^ variable.other.tcl
#               ^ punctuation.section.list.begin.tcl
#               ^^^^^^^^^^^^^^^^^^^^^ meta.list.tcl
#                ^^^^^ string.unquoted.tcl
#                      ^ meta.block.tcl punctuation.section.block.begin.tcl
#                       ^ meta.block.tcl punctuation.section.block.end.tcl
#                         ^^^^^^^ keyword.control.flow.default.tcl
#                                 ^ meta.block.tcl punctuation.section.block.begin.tcl
#                                  ^ meta.block.tcl punctuation.section.block.end.tcl
#                                   ^ punctuation.section.list.end.tcl
#                                     ^^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#                                             ^ punctuation.terminator.command.tcl
#                                               ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    switch $var {"match" {} "default" {}}
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^ variable.other.tcl
#               ^ punctuation.section.list.begin.tcl
#               ^^^^^^^^^^^^^^^^^^^^^^^^^ meta.list.tcl
#                ^^^^^^^ string.quoted.double.tcl
#                        ^ meta.block.tcl punctuation.section.block.begin.tcl
#                         ^ meta.block.tcl punctuation.section.block.end.tcl
#                           ^^^^^^^^^ string.quoted.double.tcl
#                                     ^ meta.block.tcl punctuation.section.block.begin.tcl
#                                      ^ meta.block.tcl punctuation.section.block.end.tcl
#                                       ^ punctuation.section.list.end.tcl

    switch $var {
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^ variable.other.tcl
#               ^ punctuation.section.list.begin.tcl
#               ^^ meta.list.tcl
        label -
#       ^^^^^ string.unquoted.tcl

        match {
#       ^^^^^ string.unquoted.tcl
#             ^ punctuation.section.block.begin.tcl
#             ^^ meta.block.tcl
        }
#       ^ meta.block.tcl punctuation.section.block.end.tcl
        default {}
#       ^^^^^^^ keyword.control.flow.default.tcl
#               ^ meta.block.tcl punctuation.section.block.begin.tcl
#                ^ meta.block.tcl punctuation.section.block.end.tcl
    }
#   ^ meta.list.tcl punctuation.section.list.end.tcl

    switch -exact -- $var {
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^^^ variable.parameter.tcl
#                 ^^ punctuation.terminator.switches.tcl
#                    ^^^^ variable.other.tcl
#                         ^^ meta.list.tcl
#                         ^ punctuation.section.list.begin.tcl
        label1 {
#<- meta.list.tcl
#       ^^^^^^ string.unquoted.tcl
#              ^^ meta.block.tcl
#              ^ punctuation.section.block.begin.tcl
            puts $var
#<- meta.list.tcl meta.block.tcl
#           ^^^^ meta.list.tcl meta.block.tcl support.function.builtin.tcl
        }
#<- meta.list.tcl meta.block.tcl
#       ^ meta.list.tcl meta.block.tcl punctuation.section.block.end.tcl
        label2 {
            puts "label 2"
        }
        "label [set x 3]" {puts "label 3"}
#<- meta.list.tcl
#       ^^^^^^^^^^^^^^^^^ string.quoted.double.tcl
#              ^^^^^^^^^ meta.substitution.tcl
#                         ^ punctuation.section.block.begin.tcl
#                         ^^^^^^^^^^^^^^^^ meta.list.tcl meta.block.tcl
#                                        ^ punctuation.section.block.end.tcl
#                                         ^ meta.list.tcl - meta.block
    }

    switch -glob aaab a*b - b {expr {1}} a* {expr {2}}; # comment
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^^ variable.parameter.tcl
#                ^^^^ string.unquoted.tcl
#                     ^^^ string.unquoted.tcl
#                      ^ constant.other.placeholder.tcl
#                         ^ punctuation.separator.sequence.tcl
#                           ^ string.unquoted.tcl
#                             ^^^^^^^^^^ meta.block.tcl
#                                        ^^ string.unquoted.tcl
#                                         ^ constant.other.placeholder.tcl
#                                           ^^^^^^^^^^ meta.block.tcl
#                                                     ^ punctuation.terminator.command.tcl
#                                                       ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    switch -glob {aaab} a*b - b {expr {1}} a* {expr {2}}; # comment
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^^ variable.parameter.tcl
#                ^^^^^^ meta.braces.tcl string.quoted.brace.tcl
#                       ^^^ string.unquoted.tcl
#                        ^ constant.other.placeholder.tcl
#                           ^ punctuation.separator.sequence.tcl
#                             ^ string.unquoted.tcl
#                               ^^^^^^^^^^ meta.block.tcl
#                                          ^^ string.unquoted.tcl
#                                           ^ constant.other.placeholder.tcl
#                                             ^^^^^^^^^^ meta.block.tcl
#                                                       ^ punctuation.terminator.command.tcl
#                                                         ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    switch -glob -nocase aaab a*b - b {expr {1}} a* {expr {2}}; # comment
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^^ variable.parameter.tcl
#                ^^^^^^^ variable.parameter.tcl
#                        ^^^^ string.unquoted.tcl
#                             ^^^ string.unquoted.tcl
#                              ^ constant.other.placeholder.tcl
#                                 ^ punctuation.separator.sequence.tcl
#                                   ^ string.unquoted.tcl
#                                     ^^^^^^^^^^ meta.block.tcl
#                                                ^^ string.unquoted.tcl
#                                                 ^ constant.other.placeholder.tcl
#                                                   ^^^^^^^^^^ meta.block.tcl
#                                                             ^ punctuation.terminator.command.tcl
#                                                               ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    switch -nocase -glob -invalid aaab a*b - b {expr {1}} a* {expr {2}}; # comment
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^^^^ variable.parameter.tcl
#                  ^^^^^ variable.parameter.tcl
#                        ^^^^^^^^ invalid.illegal.parameter.tcl
#                                 ^^^^ string.unquoted.tcl
#                                      ^^^ string.unquoted.tcl
#                                       ^ constant.other.placeholder.tcl
#                                          ^ punctuation.separator.sequence.tcl
#                                            ^ string.unquoted.tcl
#                                              ^^^^^^^^^^ meta.block.tcl
#                                                         ^^ string.unquoted.tcl
#                                                          ^ constant.other.placeholder.tcl
#                                                            ^^^^^^^^^^ meta.block.tcl
#                                                                      ^ punctuation.terminator.command.tcl
#                                                                        ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    switch -glob -nocase -- -aab a*b - b {expr {1}} a* {expr {2}}; # comment
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^^ variable.parameter.tcl
#                ^^^^^^^ variable.parameter.tcl
#                        ^^ punctuation.terminator.switches.tcl
#                           ^^^^ string.unquoted.tcl - variable.parameter
#                                ^^^ string.unquoted.tcl
#                                 ^ constant.other.placeholder.tcl
#                                    ^ punctuation.separator.sequence.tcl
#                                      ^ string.unquoted.tcl
#                                        ^^^^^^^^^^ meta.block.tcl
#                                                   ^^ string.unquoted.tcl
#                                                    ^ constant.other.placeholder.tcl
#                                                      ^^^^^^^^^^ meta.block.tcl
#                                                                ^ punctuation.terminator.command.tcl
#                                                                  ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    switch -glob aaab {
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^^ variable.parameter.tcl
#                ^^^^ string.unquoted.tcl
#                     ^ meta.list.tcl punctuation.section.list.begin.tcl
        a*b     -
#       ^^^ string.unquoted.tcl
#        ^ constant.other.placeholder.tcl
#               ^ punctuation.separator.sequence.tcl
        b       {expr {1}}
#       ^ string.unquoted.tcl
#               ^^^^^^^^^^ meta.block.tcl
        a*      {expr {2}}
#       ^^ string.unquoted.tcl
#        ^ constant.other.placeholder.tcl
#               ^^^^^^^^^^ meta.block.tcl
        default {expr {3}}
#       ^^^^^^^ keyword.control.flow.default.tcl
#               ^^^^^^^^^^ meta.block.tcl
    } illegal; # comment
#   ^ meta.list.tcl punctuation.section.list.end.tcl
#     ^^^^^^^ invalid.illegal.end-of-cmd-expected.tcl
#            ^ punctuation.terminator.command.tcl
#              ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    switch -regexp "aaab" [a-b]{,2} {expr {1}} b\b {expr {2}}; # comment
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^^^^ variable.parameter.tcl
#                  ^^^^^^ string.quoted.double.tcl
#                        ^ - string
#                         ^^^^^^^^^ string.unquoted.tcl string.regexp.tcl
#                         ^^^^^ meta.substitution.tcl
#                                  ^ - string - meta.block
#                                   ^^^^^^^^^^ meta.block.tcl
#                                             ^ - string - meta.block
#                                              ^^^ string.unquoted.tcl string.regexp.tcl
#                                                 ^ - string - meta.block
#                                                  ^^^^^^^^^^ meta.block.tcl
#                                                            ^ punctuation.terminator.command.tcl
#                                                              ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

# TODO: how to distinguish between braced branches with unbraced pattern and unbraced branches with braced pattern???
    switch -regexp "aaab" {[a-b]{,2}} {expr {1}} {b\b} {expr {2}}; # comment
--  ^^^^^^ keyword.control.flow.switch.tcl
--         ^^^^^^^ variable.parameter.tcl
--                 ^^^^^^ string.quoted.double.tcl
--                       ^ - string
--                        ^^^^^^^^^^^ string.quoted.brace.tcl string.regexp.tcl
--                         ^^^^^ - meta.substitution.tcl
--                                   ^ - string - meta.block
--                                    ^^^^^^^^^^ meta.block.tcl
--                                              ^ - string - meta.block
--                                               ^^^^^ string.quoted.brace.tcl string.regexp.tcl
--                                                    ^ - string - meta.block
--                                                     ^^^^^^^^^^ meta.block.tcl
--                                                               ^ punctuation.terminator.command.tcl
--                                                                 ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    switch -regexp "aaab" {[a-b]{,2} {expr {1}} b\b {expr {2}}};# comment
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^^^^ variable.parameter.tcl
#                  ^^^^^^ string.quoted.double.tcl
#                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.list.tcl
#                         ^ punctuation.section.list.begin.tcl - string
#                          ^^^^^^^^^ string.unquoted.tcl string.regexp.tcl
#                          ^^^^^ meta.substitution.tcl
#                                   ^ - string - meta.block
#                                    ^^^^^^^^^^ meta.block.tcl
#                                              ^ - string - meta.block
#                                               ^^^ string.unquoted.tcl string.regexp.tcl
#                                                  ^ - string - meta.block
#                                                   ^^^^^^^^^^ meta.block.tcl
#                                                             ^ punctuation.section.list.end.tcl
#                                                              ^ punctuation.terminator.command.tcl
#                                                               ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

    switch -regexp "aaab" {{[a-b]{,2}} {expr {1}} {b\b} {expr {2}}};# comment
#   ^^^^^^ keyword.control.flow.switch.tcl
#          ^^^^^^^ variable.parameter.tcl
#                  ^^^^^^ string.quoted.double.tcl
#                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.list.tcl
#                         ^ punctuation.section.list.begin.tcl - string
#                          ^^^^^^^^^^^ string.quoted.brace.tcl string.regexp.tcl
#                           ^^^^^ - meta.substitution.tcl
#                                     ^ - string - meta.block
#                                      ^^^^^^^^^^ meta.block.tcl
#                                                ^ - string - meta.block
#                                                 ^^^^^ string.quoted.brace.tcl string.regexp.tcl
#                                                      ^ - string - meta.block
#                                                       ^^^^^^^^^^ meta.block.tcl
#                                                                 ^ punctuation.section.list.end.tcl
#                                                                  ^ punctuation.terminator.command.tcl
#                                                                   ^ comment.line.double-dash.tcl punctuation.definition.comment.begin.tcl

##############################################################################
# try..trap..finally tests
##############################################################################

    try $foo on error {} $handler
#   ^^^ keyword.control.flow.try.tcl
#       ^^^^ variable.other.tcl
#            ^^ keyword.control.flow.on.tcl
#               ^^^^^ constant.language.errorcode.tcl
#                     ^^ meta.braces.tcl
#                        ^^^^^^^^ variable.other.tcl

    try\
#   ^^^ keyword.control.flow.try.tcl
#      ^ punctuation.separator.continuation.newline.tcl
    $foo\
#   ^^^^ variable.other.tcl
#       ^ punctuation.separator.continuation.newline.tcl
    on\
#   ^^ keyword.control.flow.on.tcl
#     ^ punctuation.separator.continuation.newline.tcl
    error\
#   ^^^^^ constant.language.errorcode.tcl
#        ^ punctuation.separator.continuation.newline.tcl
    {}\
#   ^^ meta.braces.tcl
#     ^ punctuation.separator.continuation.newline.tcl
    $handler
#   ^^^^^^^^ variable.other.tcl

    try {return -errorcode error "msg"} on return {code msg} {puts "$code: $msg"}
#   ^^^ keyword.control.flow.try.tcl
#      ^ - meta.block - keyword - punctuation
#       ^ punctuation.section.block.begin.tcl
#       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.block.tcl
#        ^^^^^^ keyword.control.flow.return.tcl
#               ^^^^^^^^^^ variable.parameter.tcl
#                          ^^^^^ constant.language.errorcode.tcl
#                                ^ punctuation.definition.string.begin.tcl
#                                ^^^^^ string.quoted.double.tcl
#                                    ^ punctuation.definition.string.end.tcl
#                                     ^ punctuation.section.block.end.tcl
#                                      ^ - meta.block - keyword - punctuation
#                                       ^^ keyword.control.flow.on.tcl
#                                         ^ - keyword - constant
#                                          ^^^^^^ constant.language.errorcode.tcl
#                                                 ^ punctuation.section.braces.begin.tcl
#                                                 ^^^^^^^^^^ meta.braces.tcl
#                                                  ^^^^ variable.other.tcl
#                                                      ^ - variable
#                                                       ^^^ variable.other.tcl
#                                                          ^ punctuation.section.braces.end.tcl
#                                                           ^ - meta.braces - meta.block - punctuation
#                                                            ^ punctuation.section.block.begin.tcl
#                                                            ^^^^^^^^^^^^^^^^^^^^ meta.block.tcl
#                                                             ^^^^ support.function.builtin.tcl
#                                                                  ^ punctuation.definition.string.begin.tcl
#                                                                  ^^^^^^^^^^^^^ string.quoted.double.tcl
#                                                                   ^ variable.other.tcl punctuation.definition.variable.tcl
#                                                                    ^^^^ variable.other.tcl
#                                                                          ^ variable.other.tcl punctuation.definition.variable.tcl
#                                                                           ^^^ variable.other.tcl
#                                                                              ^ punctuation.definition.string.end.tcl
#                                                                               ^ punctuation.section.block.end.tcl
#                                                                                ^ - meta.block - punctuation

    try {
#   ^^^ keyword.control.flow.try.tcl
#      ^ - meta.block - keyword - punctuation
#       ^ punctuation.section.block.begin.tcl
#       ^^ meta.block.tcl
        return -errorcode error "msg"
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.block.tcl
#       ^^^^^^ keyword.control.flow.return.tcl
#              ^^^^^^^^^^ variable.parameter.tcl
#                         ^^^^^ constant.language.errorcode.tcl
#                               ^^^^^ string.quoted.double.tcl
    } on return {code msg} {
#   ^ punctuation.section.block.end.tcl
#    ^ - meta.block - keyword - punctuation
#     ^^ keyword.control.flow.on.tcl
#       ^ - keyword - constant
#        ^^^^^^ constant.language.errorcode.tcl
#               ^ punctuation.section.braces.begin.tcl
#               ^^^^^^^^^^ meta.braces.tcl
#                ^^^^ variable.other.tcl
#                    ^ - variable
#                     ^^^ variable.other.tcl
#                        ^ punctuation.section.braces.end.tcl
#                         ^ - meta.braces - meta.block - punctuation
#                          ^ punctuation.section.block.begin.tcl
#                          ^^ meta.block.tcl
        puts "$code: $msg"
#^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.block.tcl
#       ^^^^ support.function.builtin.tcl
#            ^ punctuation.definition.string.begin.tcl
#            ^^^^^^^^^^^^^ string.quoted.double.tcl
#             ^ variable.other.tcl punctuation.definition.variable.tcl
#              ^^^^ variable.other.tcl
#                    ^ variable.other.tcl punctuation.definition.variable.tcl
#                     ^^^ variable.other.tcl
#                        ^ punctuation.definition.string.end.tcl
    }
#<- meta.block.tcl
#^^^^ meta.block.tcl
#   ^ punctuation.section.block.end.tcl
#    ^ - meta.block - punctuation

    try {error 5} on 5 {} {puts "foo"}
#       ^^^^^^^^^ meta.block.tcl
#                 ^^ keyword.control.flow.on.tcl
#                    ^ constant.numeric.integer.tcl
#                      ^^ meta.braces.tcl
#                         ^^^^^^^^^^^^ meta.block.tcl

    try {error 5} on [set x 5] {} {puts "foo"}
#   ^^^ keyword.control.flow.try.tcl
#       ^^^^^^^^^ meta.block.tcl
#                 ^^ keyword.control.flow.on.tcl
#                    ^^^^^^^^^ meta.substitution.tcl
#                              ^^ meta.braces.tcl
#                                 ^^^^^^^^^^^^ meta.block.tcl

    try {error 5} on $code {} {puts "foo"}
#   ^^^ keyword.control.flow.try.tcl
#       ^^^^^^^^^ meta.block.tcl
#                 ^^ keyword.control.flow.on.tcl
#                    ^^^^^ variable.other.tcl
#                          ^^ meta.braces.tcl
#                             ^^^^^^^^^^^^ meta.block.tcl

    try {error 5} on illegal {} {puts "foo"}
#   ^^^ keyword.control.flow.try.tcl
#       ^^^^^^^^^ meta.block.tcl
#                 ^^ keyword.control.flow.on.tcl
#                    ^^^^^^^ invalid.illegal.errorcode.tcl
#                            ^^ meta.braces.tcl
#                               ^^^^^^^^^^^^ meta.block.tcl

    try $foo trap $pattern {} $handler finally $handler2
#   ^^^ keyword.control.flow.try.tcl
#       ^^^^ variable.other.tcl
#            ^^^^ keyword.control.flow.trap.tcl
#                 ^^^^^^^^ variable.other.tcl
#                          ^^ meta.braces.tcl
#                             ^^^^^^^^ variable.other.tcl
#                                      ^^^^^^^ keyword.control.flow.finally.tcl
#                                              ^^^^^^^^^ variable.other.tcl

    try {
        set f [open /some/file/name w]
    } trap {POSIX EISDIR} {} {
#   ^ meta.block.tcl punctuation.section.block.end.tcl
#     ^^^^ keyword.control.flow.trap.tcl
#          ^ meta.braces.tcl punctuation.section.braces.begin.tcl
#           ^^^^^ meta.braces.tcl variable.other.tcl
#                 ^^^^^^ meta.braces.tcl variable.other.tcl
#                       ^ meta.braces.tcl punctuation.section.braces.end.tcl
#                         ^ meta.braces.tcl punctuation.section.braces.begin.tcl
#                          ^ meta.braces.tcl punctuation.section.braces.end.tcl
#                            ^ meta.block.tcl punctuation.section.block.begin.tcl
#                             ^ meta.block.tcl
        puts "failed to open /some/file/name: it's a directory"
#       ^^^^ meta.block.tcl meta.function-call.tcl support.function.builtin.tcl
#            ^ meta.block.tcl meta.function-call.parameters.tcl string.quoted.double.tcl punctuation.definition.string.begin.tcl
    } trap {POSIX ENOENT} {} {
#   ^ meta.block.tcl punctuation.section.block.end.tcl
#     ^^^^ keyword.control.flow.trap.tcl
#          ^ meta.braces.tcl punctuation.section.braces.begin.tcl
#           ^^^^^ meta.braces.tcl variable.other.tcl
#                 ^^^^^^ meta.braces.tcl variable.other.tcl
#                       ^ meta.braces.tcl punctuation.section.braces.end.tcl
#                         ^ meta.braces.tcl punctuation.section.braces.begin.tcl
#                          ^ meta.braces.tcl punctuation.section.braces.end.tcl
#                            ^ meta.block.tcl punctuation.section.block.begin.tcl
#                             ^ meta.block.tcl
        puts "failed to open /some/file/name: it doesn't exist"
#       ^^^^ meta.block.tcl meta.function-call.tcl support.function.builtin.tcl
#            ^ meta.block.tcl meta.function-call.parameters.tcl string.quoted.double.tcl punctuation.definition.string.begin.tcl
    } finally {
#   ^ meta.block.tcl punctuation.section.block.end.tcl
#     ^^^^^^^ keyword.control.flow.finally.tcl
#             ^ meta.block.tcl punctuation.section.block.begin.tcl
#              ^ meta.block.tcl
    }
#   ^ meta.block.tcl punctuation.section.block.end.tcl
