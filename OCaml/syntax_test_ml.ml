(* SYNTAX TEST "Packages/OCaml/OCaml.sublime-syntax" *)

(*
 * Merge Conflict Marker Tests
 *)

<<<<<<< HEAD
(* <- markup.conflict.begin.git punctuation.section.conflict.git *)
(*^^^^^ markup.conflict.begin.git punctuation.section.conflict.git *)
(*     ^ markup.conflict.begin.git - entity - punctuation *)
(*      ^^^^ markup.conflict.begin.git entity.name.section.conflict.git *)
(*          ^ markup.conflict.begin.git - entity - punctuation *)

=======
(* <- markup.conflict.separator.git punctuation.section.conflict.git *)
(*^^^^^ markup.conflict.separator.git punctuation.section.conflict.git *)
(*     ^ markup.conflict.separator.git - punctuation *)

>>>>>>> master
(* <- markup.conflict.end.git punctuation.section.conflict.git *)
(*^^^^^ markup.conflict.end.git punctuation.section.conflict.git *)
(*     ^ markup.conflict.end.git - entity - punctuation *)
(*      ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git *)
(*            ^ markup.conflict.end.git - entity - punctuation *)

  let open Core.Std
(*^^^ keyword.other.ocaml *)
(*    ^^^^ keyword.control.import.ocaml *)
  and open Core.Std in
(*^^^ keyword.other.ocaml *)
(*    ^^^^ keyword.control.import.ocaml *)
(*                  ^^ keyword.other.ocaml *)

  let open s =
(*^^^ keyword.other.function-definition.ocaml *)
(*    ^^^^ entity.name.function.ocaml *)
(*^^^^^^^^^^^^ meta.function.ocaml *)
  and open s =
(*^^^ keyword.other.function-definition.ocaml *)
(*    ^^^^ entity.name.function.ocaml *)
(*^^^^^^^^^^^^ meta.function.ocaml *)

  let open = 5
(*^^^ keyword.other.ocaml *)
(*    ^^^^ variable.other.constant.ocaml *)

  and open = 5
(*^^^ keyword.other.ocaml *)
(*    ^^^^ variable.other.constant.ocaml *)


(* Integers *)

    123_456_789_0n
(*  ^^^^^^^^^^^^^^ meta.number.integer.decimal.ocaml *)
(*  ^^^^^^^^^^^^^ constant.numeric.value.ocaml *)
(*               ^ constant.numeric.suffix.ocaml *)

    0
(*  ^ meta.number.integer.decimal.ocaml constant.numeric.value.ocaml *)

    123 .foo
(*  ^^^ meta.number.integer.decimal.ocaml constant.numeric.value.ocaml *)
(*     ^^^^^^ - meta.number *)

    +123  + 123
(*  ^ keyword.operator *)
(*   ^^^ meta.number.integer.decimal.ocaml constant.numeric.value.ocaml - keyword.ocaml *)
(*        ^ keyword.operator *)
(*          ^^^ meta.number.integer.decimal.ocaml constant.numeric.value.ocaml - keyword.ocaml *)

    -123
(*  ^^^^ meta.number.integer.decimal.ocaml - keyword.ocaml *)
(*  ^ keyword.operator.arithmetic.ocaml *)
(*   ^^^ constant.numeric.value.ocaml *)

    0123456789
(*  ^^^^^^^^^^ meta.number.integer.decimal.ocaml constant.numeric.value.ocaml *)

    123xyz
(*  ^^^^^^ invalid.illegal.numeric *)

    0b0110_1001_1001_0110n 0b_10_01
(*  ^^^^^^^^^^^^^^^^^^^^^^ meta.number.integer.binary.ocaml *)
(*  ^^ constant.numeric.base.ocaml *)
(*    ^^^^^^^^^^^^^^^^^^^ constant.numeric.value.ocaml *)
(*                       ^ constant.numeric.suffix.ocaml *)
(*                         ^^^^^^^^ meta.number.integer.binary.ocaml *)
(*                         ^^ constant.numeric.base.ocaml *)
(*                           ^ invalid.illegal.numeric *)
(*                            ^^^^^ constant.numeric.value.ocaml *)

    0o0123_4567n 0O_127
(*  ^^^^^^^^^^^^ meta.number.integer.octal.ocaml *)
(*  ^^ constant.numeric.base.ocaml *)
(*    ^^^^^^^^^ constant.numeric.value.ocaml *)
(*             ^ constant.numeric.suffix.ocaml *)
(*               ^^^^^^ meta.number.integer.octal.ocaml *)
(*               ^^ constant.numeric.base.ocaml *)
(*                 ^ invalid.illegal.numeric *)
(*                  ^^^ constant.numeric.value.ocaml *)

    0x01_23_45_67_89_ab_CD_efn 0X_01l
(*  ^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.number.integer.hexadecimal.ocaml *)
(*  ^^ constant.numeric.base.ocaml *)
(*    ^^^^^^^^^^^^^^^^^^^^^^^ constant.numeric.value.ocaml *)
(*                           ^ constant.numeric.suffix.ocaml *)
(*                             ^^^^^^ meta.number.integer.hexadecimal.ocaml *)
(*                             ^^ constant.numeric.base.ocaml *)
(*                               ^ invalid.illegal.numeric *)
(*                                ^^ constant.numeric.value.ocaml *)
(*                                  ^ constant.numeric.suffix.ocaml *)

    0b
(*  ^^ meta.number.integer.binary.ocaml constant.numeric.base.ocaml *)

    0B0 0O0 0X0
(*  ^^^ meta.number.integer.binary.ocaml *)
(*  ^^ constant.numeric.base.ocaml *)
(*    ^ constant.numeric.value.ocaml *)
(*      ^^^ meta.number.integer.octal.ocaml *)
(*      ^^ constant.numeric.base.ocaml *)
(*          ^^^ meta.number.integer.hexadecimal.ocaml *)
(*          ^^ constant.numeric.base.ocaml *)
(*            ^ constant.numeric.value.ocaml *)

    0xa. 0xa.b  0xa.ep1 0xa.ep-_1
(*  ^^^^ meta.number.float.hexadecimal.ocaml *)
(*  ^^ constant.numeric.base.ocaml *)
(*    ^^ constant.numeric.value.ocaml *)
(*     ^ punctuation.separator.decimal *)
(*       ^^^^^ meta.number.float.hexadecimal.ocaml *)
(*       ^^ constant.numeric.base.ocaml *)
(*         ^^^ constant.numeric.value.ocaml *)
(*          ^ punctuation.separator.decimal *)
(*              ^^^^^^^ meta.number.float.hexadecimal.ocaml *)
(*              ^^ constant.numeric.base.ocaml *)
(*                ^^^^^ constant.numeric.value.ocaml *)
(*                 ^ punctuation.separator.decimal *)
(*                      ^^^^^^^^^ meta.number.float.hexadecimal.ocaml *)
(*                      ^^ constant.numeric.base.ocaml *)
(*                        ^^^^^^^ constant.numeric.value.ocaml *)
(*                         ^ punctuation.separator.decimal *)
(*                             ^ invalid.illegal.numeric *)

    0b1.foo
(*  ^^^^^^^ invalid.illegal.numeric *)

    0b1.0
(*  ^^^^^ invalid.illegal.numeric *)

    0b123
(*  ^^^^^ invalid.illegal.numeric *)


(* Floats *)

    1_234_567_890.123_456_789_0
(*  ^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.number.float.decimal.ocaml *)
(*  ^^^^^^^^^^^^^ constant.numeric.value.ocaml *)
(*               ^ punctuation.separator.decimal.ocaml *)
(*                ^^^^^^^^^^^^^ constant.numeric.value.ocaml *)

    12345e6_7_8
(*  ^^^^^^^^^^^ meta.number.float.decimal.ocaml *)
(*  ^^^^^^^^^^^ constant.numeric.value.ocaml *)

    123.456e+789
(*  ^^^^^^^^^^^^ meta.number.float.decimal.ocaml *)
(*  ^^^^^^^^^^^^ constant.numeric.value.ocaml *)
(*     ^ punctuation.separator.decimal *)

    "string"
(*  ^^^^^^^^ meta.string.ocaml string.quoted.double.ocaml *)
(*  ^ punctuation.definition.string.begin.ocaml *)
(*         ^ punctuation.definition.string.end.ocaml *)

    "string\""
(*  ^^^^^^^^^^ meta.string.ocaml string.quoted.double.ocaml *)
(*  ^ punctuation.definition.string.begin.ocaml *)
(*         ^^ constant.character.escape.ocaml *)
(*           ^ punctuation.definition.string.end.ocaml *)

    "string\\"
(*  ^^^^^^^^^^ meta.string.ocaml string.quoted.double.ocaml *)
(*  ^ punctuation.definition.string.begin.ocaml *)
(*         ^^ constant.character.escape.ocaml *)
(*           ^ punctuation.definition.string.end.ocaml *)

    "string\
(*         ^ punctuation.separator.continuation.line.ocaml *)
    m"
(* <- meta.string.ocaml string.quoted.double.ocaml *)
(*^^^^ meta.string.ocaml string.quoted.double.ocaml *)
(*   ^ punctuation.definition.string.end.ocaml *)

    "\b \n \r \t \' \" \\ \a"
(*  ^^^^^^^^^^^^^^^^^^^^^^^^^ meta.string.ocaml string.quoted.double.ocaml *)
(*  ^ punctuation.definition.string.begin.ocaml *)
(*   ^^ constant.character.escape.ocaml *)
(*     ^ - constant.character.escape *)
(*      ^^ constant.character.escape.ocaml *)
(*        ^ - constant.character.escape *)
(*         ^^ constant.character.escape.ocaml *)
(*           ^ - constant.character.escape *)
(*            ^^ constant.character.escape.ocaml *)
(*              ^ - constant.character.escape *)
(*               ^^ constant.character.escape.ocaml *)
(*                 ^ - constant.character.escape *)
(*                  ^^ constant.character.escape.ocaml *)
(*                    ^ - constant.character.escape *)
(*                     ^^ constant.character.escape.ocaml *)
(*                       ^ - constant.character.escape *)
(*                        ^^ invalid.illegal.character.escape *)
(*                          ^ punctuation.definition.string.end.ocaml *)

    "\x \x1 \xAF \xAFG \xAG"
(*  ^^^^^^^^^^^^^^^^^^^^^^^^ meta.string.ocaml string.quoted.double.ocaml *)
(*   ^^ invalid.illegal.character.escape *)
(*     ^ - constant.character.escape *)
(*      ^^ invalid.illegal.character.escape *)
(*         ^ - constant.character.escape *)
(*          ^^^^ constant.character.escape.hexadecimal.ocaml *)
(*              ^ - constant.character.escape *)
(*               ^^^^ constant.character.escape.hexadecimal.ocaml *)
(*                    ^ - constant.character.escape *)
(*                     ^^ invalid.illegal.character.escape *)

    "\0 \01 \012 \123 \234 \345"
(*  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.string.ocaml string.quoted.double.ocaml *)
(*   ^^ invalid.illegal.character.escape *)
(*     ^ - constant.character.escape *)
(*      ^^ invalid.illegal.character.escape *)
(*         ^ - constant.character.escape *)
(*          ^^^^ constant.character.escape.decimal.ocaml *)
(*              ^ - constant.character.escape *)
(*               ^^^^ constant.character.escape.decimal.ocaml *)
(*                   ^ - constant.character.escape *)
(*                    ^^^^ constant.character.escape.decimal.ocaml *)
(*                        ^ - constant.character.escape *)
(*                         ^^ constant.character.escape.regexp.ocaml *)
(*                           ^^^ - constant.character.escape *)

    {}|
(*  ^^^ - meta.string - string *)

    {||}
(*  ^^^^ meta.string.ocaml string.quoted.other.ocaml *)
(*  ^^ punctuation.definition.string.begin.ocaml *)
(*    ^^ punctuation.definition.string.end.ocaml *)

    {|}|}
(*  ^^^^^ meta.string.ocaml string.quoted.other.ocaml *)
(*  ^^ punctuation.definition.string.begin.ocaml *)
(*     ^^ punctuation.definition.string.end.ocaml *)

    {|string|}
(*  ^^^^^^^^^^ meta.string.ocaml string.quoted.other.ocaml *)
(*  ^^ punctuation.definition.string.begin.ocaml *)
(*          ^^ punctuation.definition.string.end.ocaml *)

    {quot|string \ " |quot}
(*  ^^^^^^^^^^^^^^^^^^^^^^^ meta.string.ocaml string.quoted.other.ocaml *)
(*  ^^^^^^ punctuation.definition.string.begin.ocaml *)
(*        ^^^^^^^^^^^ - constant.character.escape - invalid *)
(*                   ^^^^^^ punctuation.definition.string.end.ocaml *)
