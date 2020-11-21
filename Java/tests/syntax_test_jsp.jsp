// SYNTAX TEST "Packages/Java/HTML (JSP).sublime-syntax"
// <- text.html.jsp - source.java.embedded.jsp
<!DOCTYPE html>
<html>
<head>
    <title></title>
//  ^^^^^^^^^^^^^^^ meta.tag

    <style type="text/css">
//  ^^^^^^^^^^^^^^^^^^^^^^^ meta.tag.style.begin.html

        @media <% print(myMedia) %> {
//      ^^^^^^ meta.at-rule.media.css keyword.control.directive.css
//             ^^^^^^^^^^^^^^^^^^^^ meta.at-rule.media.css meta.interpolation.scriptlet.jsp
//                                  ^ meta.at-rule.media.css meta.block.css punctuation.section.block.begin.css
        }

        tr.<% print(myClass); %> {
//      ^^^ meta.selector.css - meta.interpolation
//         ^^^^^^^^^^^^^^^^^^^^^ meta.selector.css meta.interpolation.scriptlet.jsp
//                               ^ - meta.selector - meta.interpolation
//         ^^ punctuation.section.interpolation.begin.jsp
//                            ^^ punctuation.section.interpolation.end.jsp
            color: <% print("<\%foo%\>"); %>;
//          ^^^^^ support.type.property-name.css
//               ^ punctuation.separator.key-value.css
//                 ^^^^^^^^^^^^^^^^^^^^^^^^^ meta.property-value.css meta.interpolation.scriptlet.jsp
//                                          ^ - meta.interpolation
//                 ^^ punctuation.section.interpolation.begin.jsp
//                    ^^^^^ variable.function.java
//                           ^^^ constant.character.escape.jsp
//                                 ^^^ constant.character.escape.jsp
//                                        ^^ punctuation.section.interpolation.end.jsp
            color: <% print('<\%bar%\>'); %>;
//          ^^^^^ support.type.property-name.css
//               ^ punctuation.separator.key-value.css
//                 ^^^^^^^^^^^^^^^^^^^^^^^^^ meta.property-value.css meta.interpolation.scriptlet.jsp
//                                          ^ - meta.interpolation
//                 ^^ punctuation.section.interpolation.begin.jsp
//                    ^^^^^ variable.function.java
//                           ^^^ constant.character.escape.jsp
//                                 ^^^ constant.character.escape.jsp
//                                        ^^ punctuation.section.interpolation.end.jsp
        }
    </style>
//  ^^^^^^^^ meta.tag.style.end.html

    <script type="text/javascript">
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.tag.script.begin.html
        <% if (true) { %>
//      ^^^^^^^^^^^^^^^^^ meta.interpolation.scriptlet.jsp
//      ^^ punctuation.section.interpolation.begin.jsp - source.java.embedded.jsp
//        ^^^^^^^^^^^^^ source.java.embedded.jsp
//                     ^^ punctuation.section.interpolation.end.jsp - source.java.embedded.jsp

            if (true) { <% print ("hello%\>") %> }
//          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ source.js.embedded.html meta.conditional.js
//                      ^^^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.scriptlet.jsp
//                      ^^ punctuation.section.interpolation.begin.jsp - source.java.embedded.jsp
//                        ^^^^^^^^^^^^^^^^^^^^ source.java.embedded.jsp
//                                      ^^^ constant.character.escape.jsp
//                                            ^^ punctuation.section.interpolation.end.jsp - source.java.embedded.jsp

        <% } else { %>
//      ^^^^^^^^^^^^^^ meta.interpolation.scriptlet.jsp
//      ^^ punctuation.section.interpolation.begin.jsp - source.java.embedded.jsp
//        ^^^^^^^^^^ source.java.embedded.jsp
//                  ^^ punctuation.section.interpolation.end.jsp - source.java.embedded.jsp

            console.write("yep");
        <% } %>
//      ^^^^^^^ meta.interpolation.scriptlet.jsp
//      ^^ punctuation.section.interpolation.begin.jsp - source.java.embedded.jsp
//        ^^^ source.java.embedded.jsp
//           ^^ punctuation.section.interpolation.end.jsp - source.java.embedded.jsp

    </script>
//  ^^^^^^^^^ meta.tag.script.end.html
</head>
<body>

    <%-- This is a comment --%>
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^ comment.block.jsp

    <!--
    ---------------------------------------------------------------------------
    -- SCRIPTLET TESTS
    ---------------------------------------------------------------------------
    -->

    <%
//  ^^ punctuation.section.interpolation.begin.jsp - source.java.embedded.jsp
//    ^ source.java.embedded.jsp - source.java source.java
    if (!foo && !bar) {
//  ^^ keyword.control.conditional.if.java
//      ^ keyword.operator.logical.java
//           ^^ keyword.operator.logical.java
    %><div style="width: <%=with%>"></div><%
//  ^^ punctuation.section.interpolation.end.jsp - source.java.embedded.jsp
//    ^^^^^ meta.tag.block.any.html - meta.attribute-with-value
//         ^^^^^^^ meta.tag.block.any.html meta.attribute-with-value.style.html - source.css
//                ^^^^^^^ meta.tag.block.any.html meta.attribute-with-value.style.html source.css - meta.expression
//                       ^^^^^^^^^ meta.tag.block.any.html meta.attribute-with-value.style.html source.css meta.interpolation.expression.jsp
//                                ^ meta.tag.block.any.html meta.attribute-with-value.style.html - source.css
//                                 ^^^^^^^ meta.tag.block.any.html - meta.attribute-with-value.style.html - source.css
//    ^ punctuation.definition.tag.begin.html
//     ^^^ entity.name.tag.block.any.html
//         ^^^^^ entity.other.attribute-name.style.html
//              ^ punctuation.separator.key-value.html
//               ^ string.quoted.double punctuation.definition.string.begin.html
//                ^^^^^ meta.property-name.css support.type.property-name.css
//                     ^ punctuation.separator.key-value.css
//                       ^^^ punctuation.section.interpolation.begin.jsp - source.java.embedded
//                          ^^^^ source.java.embedded.jsp
//                              ^^ punctuation.section.interpolation.end.jsp - source.java.embedded
//                                ^ string.quoted.double punctuation.definition.string.end.html
//                                 ^ punctuation.definition.tag.end.html
//                                        ^^ punctuation.section.interpolation.begin.jsp - source.java.embedded.jsp
        if (foot.shouldBe()) {
//      ^^ keyword.control.conditional.if.java
            boolean test = false;
//          ^^^^^^^ storage.type
//                         ^^^^^ constant
            %>
//          ^^ punctuation.section.interpolation.end.jsp - source.java.embedded.jsp
//            ^ text.html.jsp - source.java.embedded.jsp

            <%-- This is a comment --%>
//          ^^^^^^^^^^^^^^^^^^^^^^^^^^^ comment.block.jsp
            <% int aNumber = 0; // this scriptlet should close %>
//                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ comment.line.double-slash.java
//                                                             ^^ punctuation.section.interpolation.end.jsp


            <div style="width: 90%"></div>
//          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.tag
            <%
//          ^^ punctuation.section.interpolation.begin.jsp - source.java.embedded.jsp
        }
//      ^ - invalid.illegal.stray-brace-end
    }
//  ^ - invalid.illegal.stray-brace-end
    %>
//  ^^ punctuation.section.interpolation.end.jsp - source.java.embedded.jsp
//    ^ text.html.jsp - source.java.embedded.jsp



    <!-- ROOT TESTS -->

    <jsp:root
//  ^^^^^^^^^^ meta.tag.jsp.other.begin.html
//  ^ punctuation.definition.tag.begin.html
//   ^^^ entity.name.tag.namespace.html
//      ^ entity.name.tag.html punctuation.separator.namespace.html
//       ^^^^ entity.name.tag.localname.html
        xmlns:jsp="http://java.sun.com/JSP/Page"
        xmlns:public="http://www.jspcentral.com/tags"
        version="1.2"
// ^^^^^^^^^^^^^^^^^^^ meta.tag.jsp.other.begin.html
//      ^^^^^^^^^^^^^ meta.attribute-with-value.html
//      ^^^^^^^ entity.other.attribute-name.html
//             ^ punctuation.separator.key-value.html
//              ^^^^^ string.quoted.double.html
    >
//  ^ meta.tag.jsp.other.begin.html punctuation.definition.tag.end.html

    </jsp:root>
//  ^^^^^^^^^^^ meta.tag.jsp.other.end.html
//  ^^ punctuation.definition.tag.begin.html
//    ^^^ entity.name.tag.namespace.html
//       ^ punctuation.separator.namespace.html
//        ^^^^ entity.name.tag.localname.html
//            ^ punctuation.definition.tag.end.html

    <!-- DIRECTIVE TESTS -->

    <jsp:directive.include file="foo.bar" />
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.tag.jsp.directive.begin.html
//  ^ punctuation.definition.tag.begin.html
//   ^^^ entity.name.tag.namespace.html
//      ^ entity.name.tag.html punctuation.separator.namespace.html
//       ^^^^^^^^^ entity.name.tag.localname.html
//                ^ punctuation.accessor.dot.jsp
//                 ^^^^^^^ keyword.control.directive.jsp
//                         ^^^^ meta.attribute-with-value.html entity.other.attribute-name.html
//                             ^ meta.attribute-with-value.html punctuation.separator.key-value.html
//                              ^^^^^^^^^ meta.attribute-with-value.html string.quoted.double.html
//                                        ^^ punctuation.definition.tag.end.html

    <jsp:directive.include file="foo.bar"></jsp:directive>
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.tag.jsp.directive.begin.html
//                                        ^^^^^^^^^^^^^^^^ meta.tag.jsp.directive.end.html
//  ^ punctuation.definition.tag.begin.html
//   ^^^ entity.name.tag.namespace.html
//      ^ entity.name.tag.html punctuation.separator.namespace.html
//       ^^^^^^^^^ entity.name.tag.localname.html
//                ^ punctuation.accessor.dot.jsp
//                 ^^^^^^^ keyword.control.directive.jsp
//                         ^^^^ meta.attribute-with-value.html entity.other.attribute-name.html
//                             ^ meta.attribute-with-value.html punctuation.separator.key-value.html
//                              ^^^^^^^^^ meta.attribute-with-value.html string.quoted.double.html
//                                       ^ punctuation.definition.tag.end.html
//                                        ^^ punctuation.definition.tag.begin.html
//                                          ^^^ entity.name.tag.namespace.html
//                                             ^ entity.name.tag.html punctuation.separator.namespace.html
//                                              ^^^^^^^^^ entity.name.tag.localname.html
//                                                       ^ punctuation.definition.tag.end.html

    <%@ include file="foo.bar" %>
// ^ - meta
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.directive.jsp
//                               ^ - meta
//  ^^^ punctuation.section.interpolation.begin.jsp
//      ^^^^^^^ keyword.control.directive.jsp
//              ^^^^ entity.other.attribute-name.jsp
//                  ^ punctuation.separator.key-value.jsp
//                   ^^^^^^^^^ string.quoted.double.jsp
//                             ^^ punctuation.section.interpolation.end.jsp

    <!-- DECLARATION TESTS -->

    <jsp:declaration/>int i = 0;</jsp:declaration>
//  ^^^^^^^^^^^^^^^^^^ meta.tag.jsp.declaration.begin.html
//  ^ punctuation.definition.tag.begin.html
//   ^^^ entity.name.tag.namespace.html
//      ^ entity.name.tag.html punctuation.separator.namespace.html
//       ^^^^^^^^^^^ entity.name.tag.localname.html
//                  ^^ punctuation.definition.tag.end.html
//                    ^^^^^^^^^^ - source.java.embedded
//                              ^^^^^^^^^^^^^^^^^^ meta.tag.jsp.declaration.end.html
//                              ^^ punctuation.definition.tag.begin.html
//                                ^^^ entity.name.tag.namespace.html
//                                   ^ entity.name.tag.html punctuation.separator.namespace.html
//                                    ^^^^^^^^^^^ entity.name.tag.localname.html
//                                               ^ punctuation.definition.tag.end.html

    <jsp:declaration>int i = 0;</jsp:declaration>
//  ^^^^^^^^^^^^^^^^^ meta.tag.jsp.declaration.begin.html
//  ^ punctuation.definition.tag.begin.html
//   ^^^ entity.name.tag.namespace.html
//      ^ entity.name.tag.html punctuation.separator.namespace.html
//       ^^^^^^^^^^^ entity.name.tag.localname.html
//                  ^ punctuation.definition.tag.end.html
//                   ^^^^^^^^^^ source.java.embedded.jsp - source.java source.java
//                   ^^^ storage.type.primitive.java
//                             ^^^^^^^^^^^^^^^^^^ meta.tag.jsp.declaration.end.html
//                             ^^ punctuation.definition.tag.begin.html
//                               ^^^ entity.name.tag.namespace.html
//                                  ^ entity.name.tag.html punctuation.separator.namespace.html
//                                   ^^^^^^^^^^^ entity.name.tag.localname.html
//                                              ^ punctuation.definition.tag.end.html

    <%! int i = 0; %>
// ^ - meta
//  ^^^ meta.interpolation.declaration.jsp - source.java.embedded.jsp
//     ^^^^^^^^^^^^ meta.interpolation.declaration.jsp source.java.embedded.jsp - source.java source.java
//                 ^^ meta.interpolation.declaration.jsp - source.java.embedded.jsp
//                   ^ - meta
//  ^^^ punctuation.section.interpolation.begin.jsp
//      ^^^ storage.type.primitive.java
//                 ^^ punctuation.section.interpolation.end.jsp

    <!-- EXPRESSIONS TESTS -->

    The map file has <font color="<%=color.blue()%>"><%= map.size() %></font> entries.
//  ^^^^^^^^^^^^^^^^^ - meta
//                   ^^^^^^ meta.tag.inline.any.html - meta.attribute-with-value.html
//                         ^^^^^^^^^^^^^^^^^^^^^^^^^ meta.tag.inline.any.html meta.attribute-with-value.html
//                                ^^^ meta.interpolation.expression.jsp punctuation.section.interpolation.begin.jsp - source.java
//                                   ^^^^^^^^^^^^ meta.interpolation.expression.jsp source.java.embedded.jsp - source.java source.java
//                                               ^^ meta.interpolation.expression.jsp punctuation.section.interpolation.end.jsp - source.java
//                                                  ^ meta.tag.inline.any.html - meta.attribute-with-value.html
//                                                   ^^^ meta.interpolation.expression.jsp punctuation.section.interpolation.begin.jsp - source.java
//                                                      ^^^^^^^^^^^^ meta.interpolation.expression.jsp source.java.embedded.jsp
//                                                                  ^^ meta.interpolation.expression.jsp punctuation.section.interpolation.end.jsp - source.java
//                                                                    ^^^^^^^ meta.tag.inline.any.html
//                                                                           ^^^^^^^^^ - meta

    Good guess, but nope. Try<b><jsp:expression>numguess.getHint()</jsp:expression></b>.
//  ^^^^^^^^^^^^^^^^^^^^^^^^^ - meta
//                           ^^^ meta.tag.inline.any.html
//                              ^^^^^^^^^^^^^^^^ meta.tag.jsp.expression.begin.html
//                              ^ punctuation.definition.tag.begin.html
//                               ^^^ entity.name.tag.namespace.html
//                                  ^ entity.name.tag.html punctuation.separator.namespace.html
//                                   ^^^^^^^^^^ entity.name.tag.localname.html
//                                             ^ punctuation.definition.tag.end.html
//                                              ^^^^^^^^^^^^^^^^^^ source.java.embedded.jsp - source.java source.java
//                                                                ^^^^^^^^^^^^^^^^^ meta.tag.jsp.expression.end.html
//                                                                ^^ punctuation.definition.tag.begin.html
//                                                                  ^^^ entity.name.tag.namespace.html
//                                                                     ^ entity.name.tag.html punctuation.separator.namespace.html
//                                                                      ^^^^^^^^^^ entity.name.tag.localname.html
//                                                                                ^ punctuation.definition.tag.end.html
//                                                                                 ^^^^ meta.tag.inline.any.html

    Good guess, but nope. Try<b><jsp:expression/>numguess.getHint()</jsp:expression></b>.
//  ^^^^^^^^^^^^^^^^^^^^^^^^^ - meta
//                           ^^^ meta.tag.inline.any.html
//                              ^^^^^^^^^^^^^^^^ meta.tag.jsp.expression.begin.html
//                              ^ punctuation.definition.tag.begin.html
//                               ^^^ entity.name.tag.namespace.html
//                                  ^ entity.name.tag.html punctuation.separator.namespace.html
//                                   ^^^^^^^^^^ entity.name.tag.localname.html
//                                             ^^ punctuation.definition.tag.end.html
//                                               ^^^^^^^^^^^^^^^^^^ - source.java.embedded
//                                                                 ^^^^^^^^^^^^^^^^^ meta.tag.jsp.expression.end.html
//                                                                 ^^ punctuation.definition.tag.begin.html
//                                                                   ^^^ entity.name.tag.namespace.html
//                                                                      ^ entity.name.tag.html punctuation.separator.namespace.html
//                                                                       ^^^^^^^^^^ entity.name.tag.localname.html
//                                                                                 ^ punctuation.definition.tag.end.html
//                                                                                  ^^^^ meta.tag.inline.any.html

    <!-- FORWARD TESTS -->

    <jsp:forward page="/servlet/login" />
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.tag.jsp.other.begin.html
//  ^ punctuation.definition.tag.begin.html
//   ^^^ entity.name.tag.namespace.html
//      ^ punctuation.separator.namespace.html
//       ^^^^^^^ entity.name.tag.localname.html
//                                     ^^ punctuation.definition.tag.end.html

    <jsp:forward page="/servlet/login">
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.tag.jsp.other.begin.html
//  ^ punctuation.definition.tag.begin.html
//   ^^^ entity.name.tag.namespace.html
//      ^ punctuation.separator.namespace.html
//       ^^^^^^^ entity.name.tag.localname.html
//                                    ^ punctuation.definition.tag.end.html

        <jsp:param name="username" value="jsmith" />
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.tag.jsp.other.begin.html
//      ^ punctuation.definition.tag.begin.html
//       ^^^ entity.name.tag.namespace.html
//          ^ punctuation.separator.namespace.html
//           ^^^^^ entity.name.tag.localname.html
//                                                ^^ punctuation.definition.tag.end.html

    </jsp:forward>
//  ^^^^^^^^^^^^^^ meta.tag.jsp.other.end.html
//  ^^ punctuation.definition.tag.begin.html
//    ^^^ entity.name.tag.namespace.html
//       ^ punctuation.separator.namespace.html
//        ^^^^^^^ entity.name.tag.localname.html
//               ^ punctuation.definition.tag.end.html

    <!-- SCRIPTLET TESTS -->


    Plain text
//  ^^^^^^^^^^ text.html.jsp - meta

    <jsp:text/>Plain text</jsp:text>
//  ^^^^^^^^^^^ meta.tag.jsp.text.begin.html
//  ^ punctuation.definition.tag.begin.html
//   ^^^ entity.name.tag.namespace.html
//      ^ punctuation.separator.namespace.html
//       ^^^^ entity.name.tag.localname.html
//           ^^ punctuation.definition.tag.end.html
//             ^^^^^^^^^^ - text.plain.jsp
//                       ^^^^^^^^^^^ meta.tag.jsp.text.end.html
//                       ^^ punctuation.definition.tag.begin.html
//                         ^^^ entity.name.tag.namespace.html
//                            ^ punctuation.separator.namespace.html
//                             ^^^^ entity.name.tag.localname.html
//                                 ^ punctuation.definition.tag.end.html

    <jsp:text>Plain text</jsp:text>
//  ^^^^^^^^^^ meta.tag.jsp.text.begin.html
//  ^ punctuation.definition.tag.begin.html
//   ^^^ entity.name.tag.namespace.html
//      ^ punctuation.separator.namespace.html
//       ^^^^ entity.name.tag.localname.html
//           ^ punctuation.definition.tag.end.html
//            ^^^^^^^^^^ text.plain.jsp
//                      ^^^^^^^^^^^ meta.tag.jsp.text.end.html
//                      ^^ punctuation.definition.tag.begin.html
//                        ^^^ entity.name.tag.namespace.html
//                           ^ punctuation.separator.namespace.html
//                            ^^^^ entity.name.tag.localname.html
//                                ^ punctuation.definition.tag.end.html

</body>
</html>
