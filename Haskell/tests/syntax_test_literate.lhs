% SYNTAX TEST "Packages/Haskell/Literate Haskell.sublime-syntax"

<<<<<<< HEAD
%  <- markup.conflict.begin.git punctuation.section.conflict.git
% ^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
%      ^ markup.conflict.begin.git - entity - punctuation
%       ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
%           ^ markup.conflict.begin.git - entity - punctuation

=======
%  <- markup.conflict.separator.git punctuation.section.conflict.git
% ^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
%      ^ markup.conflict.separator.git - punctuation

>>>>>>> master
%  <- markup.conflict.end.git punctuation.section.conflict.git
% ^^^^^ markup.conflict.end.git punctuation.section.conflict.git
%      ^ markup.conflict.end.git - entity - punctuation
%       ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
%             ^ markup.conflict.end.git - entity - punctuation

    \begin{code}
%  ^^^^^^^^^^^^^ - source.haskell
%               ^ source.haskell.embedded.latex
%   ^ punctuation.definition.backslash.latex
%   ^^^^^^ support.function.begin.latex keyword.control.block.begin.latex
%         ^ punctuation.definition.group.brace.begin.tex
%          ^^^^ variable.parameter.function.latex
%              ^ punctuation.definition.group.brace.end.tex

    {- comment -}
%   ^^^^^^^^^^^^^ source.haskell.embedded.latex comment.block.haskell

    {-# LANGUAGE EmptyCase #-}
%   ^^^^^^^^^^^^^^^^^^^^^^^^^^ source.haskell.embedded.latex
%   ^^^^^^^^^^^^ meta.preprocessor.pragma.directive.haskell
%               ^^^^^^^^^^^ meta.preprocessor.pragma.value.language.haskell
%                          ^^^ meta.preprocessor.pragma.value.haskell

    \end{code}
%  ^ source.haskell.embedded.latex
%   ^^^^^^^^^^^ - source.haskell
%   ^ punctuation.definition.backslash.latex
%   ^^^^ support.function.end.latex keyword.control.block.end.latex
%       ^ punctuation.definition.group.brace.begin.tex
%        ^^^^ variable.parameter.function.latex
%            ^ punctuation.definition.group.brace.end.tex
