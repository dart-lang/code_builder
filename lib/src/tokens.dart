// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/src/dart/ast/token.dart';

// Keywords
final Token $abstract = new KeywordToken(Keyword.ABSTRACT, 0);
final Token $extends = new KeywordToken(Keyword.EXTENDS, 0);
final Token $implements = new KeywordToken(Keyword.IMPLEMENTS, 0);
final Token $with = new KeywordToken(Keyword.WITH, 0);
final Token $static = new KeywordToken(Keyword.STATIC, 0);
final Token $final = new KeywordToken(Keyword.FINAL, 0);
final Token $const = new KeywordToken(Keyword.CONST, 0);
final Token $var = new KeywordToken(Keyword.VAR, 0);
final Token $this = new KeywordToken(Keyword.THIS, 0);
final Token $library = new KeywordToken(Keyword.LIBRARY, 0);
final Token $part = new KeywordToken(Keyword.PART, 0);
final Token $of = new StringToken(TokenType.KEYWORD, 'of', 0);
final Token $true = new KeywordToken(Keyword.TRUE, 0);
final Token $false = new KeywordToken(Keyword.FALSE, 0);
final Token $null = new KeywordToken(Keyword.NULL, 0);
final Token $new = new KeywordToken(Keyword.NEW, 0);

// Simple tokens
final Token $closeParen = new Token(TokenType.CLOSE_PAREN, 0);
final Token $openParen = new Token(TokenType.OPEN_PAREN, 0);
final Token $openCurly = new Token(TokenType.OPEN_CURLY_BRACKET, 0);
final Token $closeCurly = new Token(TokenType.CLOSE_CURLY_BRACKET, 0);
final Token $semicolon = new Token(TokenType.SEMICOLON, 0);
final Token $equals = new Token(TokenType.EQ, 0);
final Token $nullAwareEquals = new Token(TokenType.QUESTION_QUESTION_EQ, 0);
final Token $period = new Token(TokenType.PERIOD, 0);
final Token $colon = new Token(TokenType.COLON, 0);

/// Returns a string token for the given string [s].
StringToken stringToken(String s) => new StringToken(TokenType.STRING, s, 0);

/// Returns an int token for the given int [value].
StringToken intToken(int value) => new StringToken(TokenType.INT, '$value', 0);
