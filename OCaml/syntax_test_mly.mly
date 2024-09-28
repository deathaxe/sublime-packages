/* SYNTAX TEST "Packages/OCaml/OCamlyacc.sublime-syntax" */
/*  This is a comment
 *  at the beginning of the file
/* ^ comment */
 */

%{
open Support.Error
/* ^ meta.header.ocamlyacc meta.module.open.ocaml */
%}

/*
 * Merge Conflict Marker Tests
 */

<<<<<<< HEAD
/* <- markup.conflict.begin.git punctuation.section.conflict.git */
/*^^^^^ markup.conflict.begin.git punctuation.section.conflict.git */
/*     ^ markup.conflict.begin.git - entity - punctuation */
/*      ^^^^ markup.conflict.begin.git entity.name.section.conflict.git */
/*          ^ markup.conflict.begin.git - entity - punctuation */

=======
/* <- markup.conflict.separator.git punctuation.section.conflict.git */
/*^^^^^ markup.conflict.separator.git punctuation.section.conflict.git */
/*     ^ markup.conflict.separator.git - punctuation */

>>>>>>> master
/* <- markup.conflict.end.git punctuation.section.conflict.git */
/*^^^^^ markup.conflict.end.git punctuation.section.conflict.git */
/*     ^ markup.conflict.end.git - entity - punctuation */
/*      ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git */
/*            ^ markup.conflict.end.git - entity - punctuation */

