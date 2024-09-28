# SYNTAX TEST "Packages/Python/Python.sublime-syntax"

## Top-level

<<<<<<< HEAD
# <- markup.conflict.begin.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
#      ^ markup.conflict.begin.git - entity - punctuation
#       ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
#           ^ markup.conflict.begin.git - entity - punctuation

=======
# <- markup.conflict.separator.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
#      ^ markup.conflict.separator.git - punctuation

>>>>>>> master
# <- markup.conflict.end.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.end.git punctuation.section.conflict.git
#      ^ markup.conflict.end.git - entity - punctuation
#       ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
#             ^ markup.conflict.end.git - entity - punctuation

in_dicts = {    
<<<<<<< HEAD
# <- markup.conflict.begin.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
#      ^ markup.conflict.begin.git - entity - punctuation
#       ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
#           ^ markup.conflict.begin.git - entity - punctuation
    "ours": "val",
#^^^ meta.mapping.python
#   ^^^^^^ meta.mapping.key.python meta.string.python string.quoted.double.python
#   ^ punctuation.definition.string.begin.python
#        ^ punctuation.definition.string.end.python
#         ^^ meta.mapping.python
#         ^ punctuation.separator.key-value.python
#           ^^^^^ meta.mapping.value.python meta.string.python string.quoted.double.python
#           ^ punctuation.definition.string.begin.python
#               ^ punctuation.definition.string.end.python
#                ^ meta.mapping.python punctuation.separator.sequence.python
=======
# <- markup.conflict.separator.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
#      ^ markup.conflict.separator.git - punctuation
    "theirs": "bar"
#^^^ meta.mapping.python
#   ^^^^^^^^ meta.mapping.key.python meta.string.python string.quoted.double.python
#   ^ punctuation.definition.string.begin.python
#          ^ punctuation.definition.string.end.python
#           ^^ meta.mapping.python
#           ^ punctuation.separator.key-value.python
#             ^^^^^ meta.mapping.value.python meta.string.python string.quoted.double.python
#             ^ punctuation.definition.string.begin.python
#                 ^ punctuation.definition.string.end.python
>>>>>>> master
# <- markup.conflict.end.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.end.git punctuation.section.conflict.git
#      ^ markup.conflict.end.git - entity - punctuation
#       ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
#             ^ markup.conflict.end.git - entity - punctuation
}

in_lists = [
<<<<<<< HEAD
# <- markup.conflict.begin.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
#      ^ markup.conflict.begin.git - entity - punctuation
#       ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
#           ^ markup.conflict.begin.git - entity - punctuation
    "ours",
#   ^^^^^^ meta.sequence.list.python meta.string.python string.quoted.double.python
#   ^ punctuation.definition.string.begin.python
#        ^ punctuation.definition.string.end.python
#         ^ punctuation.separator.sequence.python
=======
# <- markup.conflict.separator.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
#      ^ markup.conflict.separator.git - punctuation
    "theirs"
#   ^^^^^^^^ meta.sequence.list.python meta.string.python string.quoted.double.python
#   ^ punctuation.definition.string.begin.python
#          ^ punctuation.definition.string.end.python
>>>>>>> master
# <- markup.conflict.end.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.end.git punctuation.section.conflict.git
#      ^ markup.conflict.end.git - entity - punctuation
#       ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
#             ^ markup.conflict.end.git - entity - punctuation
]

in_sets = {
<<<<<<< HEAD
# <- markup.conflict.begin.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
#      ^ markup.conflict.begin.git - entity - punctuation
#       ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
#           ^ markup.conflict.begin.git - entity - punctuation
    "ours",
#   ^^^^^^ meta.set.python meta.string.python string.quoted.double.python
#   ^ punctuation.definition.string.begin.python
#        ^ punctuation.definition.string.end.python
#         ^ punctuation.separator.set.python
=======
# <- markup.conflict.separator.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
#      ^ markup.conflict.separator.git - punctuation
    "theirs"
#   ^^^^^^^^ meta.set.python meta.string.python string.quoted.double.python
#   ^ punctuation.definition.string.begin.python
#          ^ punctuation.definition.string.end.python
>>>>>>> master
# <- markup.conflict.end.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.end.git punctuation.section.conflict.git
#      ^ markup.conflict.end.git - entity - punctuation
#       ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
#             ^ markup.conflict.end.git - entity - punctuation
}

in_tuples = (
<<<<<<< HEAD
# <- markup.conflict.begin.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
#      ^ markup.conflict.begin.git - entity - punctuation
#       ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
#           ^ markup.conflict.begin.git - entity - punctuation
    "ours",
#   ^^^^^^ meta.sequence.tuple.python meta.string.python string.quoted.double.python
#   ^ punctuation.definition.string.begin.python
#        ^ punctuation.definition.string.end.python
#         ^ punctuation.separator.sequence.python
=======
# <- markup.conflict.separator.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
#      ^ markup.conflict.separator.git - punctuation
    "theirs"
#   ^^^^^^^^ meta.sequence.tuple.python meta.string.python string.quoted.double.python
#   ^ punctuation.definition.string.begin.python
#          ^ punctuation.definition.string.end.python
>>>>>>> master
# <- markup.conflict.end.git punctuation.section.conflict.git
# ^^^^^ markup.conflict.end.git punctuation.section.conflict.git
#      ^ markup.conflict.end.git - entity - punctuation
#       ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
#             ^ markup.conflict.end.git - entity - punctuation
)

in_strings = """
<<<<<<< HEAD
# <- markup.conflict.begin.git punctuation.section.conflict.git
#^^^^^^^^^^^^ meta.string.python string.quoted.double.block.python
# ^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
#      ^ markup.conflict.begin.git - entity - punctuation
#       ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
#           ^ markup.conflict.begin.git - entity - punctuation
    ours
#^^^^^^^ meta.string.python string.quoted.double.block.python
=======
# <- markup.conflict.separator.git punctuation.section.conflict.git
#^^^^^^^ meta.string.python string.quoted.double.block.python
# ^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
#      ^ markup.conflict.separator.git - punctuation
    theirs
#^^^^^^^^^^ meta.string.python string.quoted.double.block.python
>>>>>>> master
# <- markup.conflict.end.git punctuation.section.conflict.git
#^^^^^^^^^^^^^^ meta.string.python string.quoted.double.block.python
# ^^^^^ markup.conflict.end.git punctuation.section.conflict.git
#      ^ markup.conflict.end.git - entity - punctuation
#       ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
#             ^ markup.conflict.end.git - entity - punctuation
"""

in_strings = b"""
<<<<<<< HEAD
# <- markup.conflict.begin.git punctuation.section.conflict.git
#^^^^^^^^^^^^ meta.string.python string.quoted.double.block.python
# ^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
#      ^ markup.conflict.begin.git - entity - punctuation
#       ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
#           ^ markup.conflict.begin.git - entity - punctuation
    ours
#^^^^^^^ meta.string.python string.quoted.double.block.python
=======
# <- markup.conflict.separator.git punctuation.section.conflict.git
#^^^^^^^ meta.string.python string.quoted.double.block.python
# ^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
#      ^ markup.conflict.separator.git - punctuation
    theirs
#^^^^^^^^^^ meta.string.python string.quoted.double.block.python
>>>>>>> master
# <- markup.conflict.end.git punctuation.section.conflict.git
#^^^^^^^^^^^^^^ meta.string.python string.quoted.double.block.python
# ^^^^^ markup.conflict.end.git punctuation.section.conflict.git
#      ^ markup.conflict.end.git - entity - punctuation
#       ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
#             ^ markup.conflict.end.git - entity - punctuation
"""

in_strings = f"""
<<<<<<< HEAD
# <- markup.conflict.begin.git punctuation.section.conflict.git
#^^^^^^^^^^^^ meta.string.python string.quoted.double.block.python
# ^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
#      ^ markup.conflict.begin.git - entity - punctuation
#       ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
#           ^ markup.conflict.begin.git - entity - punctuation
    ours
#^^^^^^^ meta.string.python string.quoted.double.block.python
=======
# <- markup.conflict.separator.git punctuation.section.conflict.git
#^^^^^^^ meta.string.python string.quoted.double.block.python
# ^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
#      ^ markup.conflict.separator.git - punctuation
    theirs
#^^^^^^^^^^ meta.string.python string.quoted.double.block.python
>>>>>>> master
# <- markup.conflict.end.git punctuation.section.conflict.git
#^^^^^^^^^^^^^^ meta.string.python string.quoted.double.block.python
# ^^^^^ markup.conflict.end.git punctuation.section.conflict.git
#      ^ markup.conflict.end.git - entity - punctuation
#       ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
#             ^ markup.conflict.end.git - entity - punctuation
"""

in_strings = r"""
<<<<<<< HEAD
# <- markup.conflict.begin.git punctuation.section.conflict.git
#^^^^^^^^^^^^ meta.string.python string.quoted.double.block.python
# ^^^^^ markup.conflict.begin.git punctuation.section.conflict.git
#      ^ markup.conflict.begin.git - entity - punctuation
#       ^^^^ markup.conflict.begin.git entity.name.section.conflict.git
#           ^ markup.conflict.begin.git - entity - punctuation
    ours
#^^^^^^^ meta.string.python string.quoted.double.block.python
=======
# <- markup.conflict.separator.git punctuation.section.conflict.git
#^^^^^^^ meta.string.python string.quoted.double.block.python
# ^^^^^ markup.conflict.separator.git punctuation.section.conflict.git
#      ^ markup.conflict.separator.git - punctuation
    theirs
#^^^^^^^^^^ meta.string.python string.quoted.double.block.python
>>>>>>> master
# <- markup.conflict.end.git punctuation.section.conflict.git
#^^^^^^^^^^^^^^ meta.string.python string.quoted.double.block.python
# ^^^^^ markup.conflict.end.git punctuation.section.conflict.git
#      ^ markup.conflict.end.git - entity - punctuation
#       ^^^^^^ markup.conflict.end.git entity.name.section.conflict.git
#             ^ markup.conflict.end.git - entity - punctuation
"""
