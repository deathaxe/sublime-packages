-- SYNTAX TEST "Packages/AppleScript/AppleScript.sublime-syntax"

<<<<<<< HEAD
-- <- markup.conflict.begin.git punctuation.section.conflict.git
--^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
--     ^ markup.conflict.begin.git - entity - punctuation
--      ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
--          ^ markup.conflict.begin.git - entity - punctuation

=======
-- <- markup.conflict.separator.git punctuation.section.conflict.git
--^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
--     ^ markup.conflict.separator.git - punctuation

>>>>>>> foo/bar
-- <- markup.conflict.end.git punctuation.section.conflict.git
--^^^^^ markup.conflict.end.git punctuation.section.conflict.git
--     ^ markup.conflict.end.git - entity - punctuation
--      ^^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
--             ^ markup.conflict.end.git - entity - punctuation

(* Conflict in block comment
<<<<<<< HEAD
-- <- markup.conflict.begin.git punctuation.section.conflict.git
--^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
--     ^ markup.conflict.begin.git - entity - punctuation
--      ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
--          ^ markup.conflict.begin.git - entity - punctuation

=======
-- <- markup.conflict.separator.git punctuation.section.conflict.git
--^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
--     ^ markup.conflict.separator.git - punctuation

>>>>>>> master
-- <- markup.conflict.end.git punctuation.section.conflict.git
--^^^^^ markup.conflict.end.git punctuation.section.conflict.git
--     ^ markup.conflict.end.git - entity - punctuation
--      ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
--            ^ markup.conflict.end.git - entity - punctuation
*)

{ (* conflict in block *)
<<<<<<< HEAD
-- <- markup.conflict.begin.git punctuation.section.conflict.git
--^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
--     ^ markup.conflict.begin.git - entity - punctuation
--      ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
--          ^ markup.conflict.begin.git - entity - punctuation

=======
-- <- markup.conflict.separator.git punctuation.section.conflict.git
--^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
--     ^ markup.conflict.separator.git - punctuation

>>>>>>> master
-- <- markup.conflict.end.git punctuation.section.conflict.git
--^^^^^ markup.conflict.end.git punctuation.section.conflict.git
--     ^ markup.conflict.end.git - entity - punctuation
--      ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
--            ^ markup.conflict.end.git - entity - punctuation
}

( (* conflict in group *)
<<<<<<< HEAD
-- <- markup.conflict.begin.git punctuation.section.conflict.git
--^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
--     ^ markup.conflict.begin.git - entity - punctuation
--      ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
--          ^ markup.conflict.begin.git - entity - punctuation

=======
-- <- markup.conflict.separator.git punctuation.section.conflict.git
--^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
--     ^ markup.conflict.separator.git - punctuation

>>>>>>> master
-- <- markup.conflict.end.git punctuation.section.conflict.git
--^^^^^ markup.conflict.end.git punctuation.section.conflict.git
--     ^ markup.conflict.end.git - entity - punctuation
--      ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
--            ^ markup.conflict.end.git - entity - punctuation
)
