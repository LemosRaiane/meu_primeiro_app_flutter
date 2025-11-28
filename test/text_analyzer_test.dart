import 'package:flutter_test/flutter_test.dart';
import 'package:meu_primeiro_app_flutter/services/text_analyzer.dart';

void main() {
  test('basic analysis counts words and sentences', () {
    final text = 'Hello world. This is a test!';
    final result = TextAnalyzer.analyze(text);

    expect(result.wordCount, greaterThanOrEqualTo(5));
    expect(result.sentenceCount, 2);
    expect(result.charCountWithSpaces, greaterThan(0));
    expect(result.topWords.containsKey('this') || result.topWords.containsKey('hello'), true);
  });
}
