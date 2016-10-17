// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/src/dart/ast/token.dart';

/// The `abstract` token.
final Token $abstract = new KeywordToken(Keyword.ABSTRACT, 0);

/// The `assert` token.
final Token $assert = new KeywordToken(Keyword.ASSERT, 0);

/// The `@` token.
final Token $at = new Token(TokenType.AT, 0);

/// The `class` token.
final Token $class = new KeywordToken(Keyword.CLASS, 0);

/// The `]` token.
final Token $closeBracket = new Token(TokenType.CLOSE_SQUARE_BRACKET, 0);

/// The '}' token.
final Token $closeCurly = new Token(TokenType.CLOSE_CURLY_BRACKET, 0);

/// The ')' token.
final Token $closeParen = new Token(TokenType.CLOSE_PAREN, 0);

/// The ':' token.
final Token $colon = new Token(TokenType.COLON, 0);

/// The `const` token.
final Token $const = new KeywordToken(Keyword.CONST, 0);

/// The `/` token.
final Token $divide = new Token(TokenType.SLASH, 0);

/// The `else` token.
final Token $else = new KeywordToken(Keyword.ELSE, 0);

/// The '=' token.
final Token $equals = new Token(TokenType.EQ, 0);

/// The `==` token.
final Token $equalsEquals = new Token(TokenType.EQ_EQ, 0);

/// The `extends` token.
final Token $extends = new KeywordToken(Keyword.EXTENDS, 0);

/// The `false` token.
final Token $false = new KeywordToken(Keyword.FALSE, 0);

/// The `final` token.
final Token $final = new KeywordToken(Keyword.FINAL, 0);

/// The `>` token.
final Token $gt = new Token(TokenType.GT, 0);

/// The `if` token.
final Token $if = new KeywordToken(Keyword.IF, 0);

// Simple tokens

/// The `implements` token.
final Token $implements = new KeywordToken(Keyword.IMPLEMENTS, 0);

/// The `library` token.
final Token $library = new KeywordToken(Keyword.LIBRARY, 0);

/// The `<` token.
final Token $lt = new Token(TokenType.LT, 0);

/// The `-` token.
final Token $minus = new Token(TokenType.MINUS, 0);

/// The `*` token.
final Token $multiply = new Token(TokenType.STAR, 0);

/// The `new` token.
final Token $new = new KeywordToken(Keyword.NEW, 0);

/// The `!` token.
final Token $not = new Token(TokenType.BANG, 0);

/// The `!=` token.
final Token $notEquals = new Token(TokenType.BANG_EQ, 0);

/// The `null` token.
final Token $null = new KeywordToken(Keyword.NULL, 0);

/// The '??=' token.
final Token $nullAwareEquals = new Token(TokenType.QUESTION_QUESTION_EQ, 0);

/// The `of` token.
final Token $of = new StringToken(TokenType.KEYWORD, 'of', 0);

/// The '[` token.
final Token $openBracket = new Token(TokenType.OPEN_SQUARE_BRACKET, 0);

/// The '{' token.
final Token $openCurly = new Token(TokenType.OPEN_CURLY_BRACKET, 0);

/// The '(' token.
final Token $openParen = new Token(TokenType.OPEN_PAREN, 0);

/// The `part` token.
final Token $part = new KeywordToken(Keyword.PART, 0);

/// The '.' token.
final Token $period = new Token(TokenType.PERIOD, 0);

/// The `+` token.
final Token $plus = new Token(TokenType.PLUS, 0);

/// The `return` token.
final Token $return = new KeywordToken(Keyword.RETURN, 0);

/// The ';' token.
final Token $semicolon = new Token(TokenType.SEMICOLON, 0);

/// The `static` token.
final Token $static = new KeywordToken(Keyword.STATIC, 0);

/// The `this` token.
final Token $this = new KeywordToken(Keyword.THIS, 0);

/// The `true` token.
final Token $true = new KeywordToken(Keyword.TRUE, 0);

/// The `var` token.
final Token $var = new KeywordToken(Keyword.VAR, 0);

/// The `with` token.
final Token $with = new KeywordToken(Keyword.WITH, 0);

/// Returns an int token for the given int [value].
StringToken intToken(int value) => new StringToken(TokenType.INT, '$value', 0);

/// Returns a string token for the given string [s].
StringToken stringToken(String s) => new StringToken(TokenType.STRING, s, 0);
