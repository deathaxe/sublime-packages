// SYNTAX TEST "Packages/Pascal/Pascal.sublime-syntax"

  // double slash comment
// <- punctuation.whitespace.comment.leading.pascal
  // <- punctuation.definition.comment.pascal
  // ^^^^^^^^^^^^^^^^^^^^ comment.line.double-slash.pascal.two

  -- double dash comment
// <- punctuation.whitespace.comment.leading.pascal
  // <- punctuation.definition.comment.pascal
  // ^^^^^^^^^^^^^^^^^^^ comment.line.double-dash.pascal.one

// comment
procedure foo;
// ^ meta.function.pascal keyword.declaration.function
begin
	// comment
end;
// <- keyword.control.pascal

-- comment
procedure bar;
// ^ meta.function.pascal keyword.declaration.function
begin
	-- comment
end;
// <- keyword.control.pascal

<<<<<<< HEAD
// <- markup.conflict.begin.git punctuation.section.conflict.git
//^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
//     ^ markup.conflict.begin.git - entity - punctuation
//      ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
//          ^ markup.conflict.begin.git - entity - punctuation

=======
// <- markup.conflict.separator.git punctuation.section.conflict.git
//^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
//     ^ markup.conflict.separator.git - punctuation

>>>>>>> master
// <- markup.conflict.end.git punctuation.section.conflict.git
//^^^^^ markup.conflict.end.git punctuation.section.conflict.git
//     ^ markup.conflict.end.git - entity - punctuation
//      ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
//            ^ markup.conflict.end.git - entity - punctuation
