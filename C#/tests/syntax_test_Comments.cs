//* SYNTAX TEST "Packages/C#/C#.sublime-syntax"

// A Hello World! program in C#.
//*<- comment.line
using System;

namespace HelloWorld
{
    /// <summary>
//* ^^^ punctuation.definition.comment.documentation.cs
//* ^^^^^^^^^^^^^^ comment.line.documentation
//*     ^ punctuation.definition.tag.begin
//*      ^^^^^^^ entity.name.tag.begin
//*             ^ punctuation.definition.tag.end
//*    ^ text.documentation
//*     ^^^^^^^^^ - text.documentation
//*              ^ text.documentation
    /// This class is testing comments
//* ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ comment.line.documentation
//*    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ text.documentation
    /// </summary>
//*     ^^ punctuation.definition.tag.begin
//*       ^^^^^^^ entity.name.tag.end
//*              ^ punctuation.definition.tag.end
    /// <see href="http://foo.com">Reference</see>
//*     ^^^^^^^^^^^^^^^^^^^^^^^^^^^ - text.documentation
//*     ^ punctuation.definition.tag.begin
//*      ^^^ entity.name.tag
//*          ^^^^ entity.other.attribute-name
//*              ^ punctuation.separator.argument.value
//*                               ^ punctuation.definition.tag.end
//*                                ^^^^^^^^^ text.documentation
    /**
        *
//*     ^ meta.namespace.cs meta.block.cs comment.block.cs punctuation.definition.comment.cs 
    */
    class Hello
    {
        /// <summary>
        /// Computes matrix-matrix product of a sparse matrix stored in the CSC format.
//*         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ text.documentation
        /// </summary>
        void dcscmm(Transpose TransA, int m, int n, int k,
            double alpha,
            double[] val, int offsetval,
            int[] indx, int offsetindx,
            int[] pntrb, int offsetpntrb,
            //int[] pntre, int offsetpntre,
            double[] b, int offsetb, int ldb,
            double beta,
            double[] c, int offsetc, int ldc);
    }
}

class MergeConflict {
<<<<<<< HEAD
// <- markup.conflict.begin.git punctuation.section.conflict.git
//^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
//     ^ markup.conflict.begin.git - entity - punctuation
//      ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
//          ^ markup.conflict.begin.git - entity - punctuation
    void main(int foo) {
=======
// <- markup.conflict.separator.git punctuation.section.conflict.git
//^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
//     ^ markup.conflict.separator.git - punctuation
    void main(bool bar) {
>>>>>>> master
// <- markup.conflict.end.git punctuation.section.conflict.git
//^^^^^ markup.conflict.end.git punctuation.section.conflict.git
//     ^ markup.conflict.end.git - entity - punctuation
//      ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
//            ^ markup.conflict.end.git - entity - punctuation
    }
}