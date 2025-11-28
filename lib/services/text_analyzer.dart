import 'dart:math';

import '../models/analysis_result.dart';

class TextAnalyzer {
  /// Main entry: analyze text and return AnalysisResult
  static AnalysisResult analyze(String text, {int topN = 10}) {
    final trimmed = text.trim();
    final charWithSpaces = trimmed.length;
    final charWithoutSpaces = trimmed.replaceAll(RegExp(r"\s+"), '').length;

    final words = _extractWords(trimmed);
    final wordCount = words.length;

    final sentenceCount = _countSentences(trimmed);

    final avgWordsPerSentence = sentenceCount > 0 ? wordCount / sentenceCount : (wordCount > 0 ? wordCount.toDouble() : 0.0);

    final topWords = _topFrequencies(words, topN);

    final syllables = _countSyllablesInWords(words);

    final flesch = _fleschReadingEase(wordCount, sentenceCount, syllables);

    final estMinutes = wordCount > 0 ? wordCount / 200.0 : 0.0;

    return AnalysisResult(
      charCountWithSpaces: charWithSpaces,
      charCountWithoutSpaces: charWithoutSpaces,
      wordCount: wordCount,
      sentenceCount: sentenceCount,
      avgWordsPerSentence: double.parse(avgWordsPerSentence.toStringAsFixed(2)),
      fleschReadingEase: double.parse(flesch.toStringAsFixed(2)),
      estimatedReadingMinutes: double.parse(estMinutes.toStringAsFixed(2)),
      topWords: topWords,
      syllableCount: syllables,
    );
  }

  static List<String> _extractWords(String text) {
    if (text.isEmpty) return [];
    final matches = RegExp(r"[A-Za-zÀ-ÿ0-9']+").allMatches(text);
    return matches.map((m) => m.group(0)!.toLowerCase()).toList();
  }

  static int _countSentences(String text) {
    if (text.isEmpty) return 0;
    // Simple heuristic: split on . ! ? and count non-empty parts
    final parts = text.split(RegExp(r'[.!?]+'));
    return parts.where((p) => p.trim().isNotEmpty).length;
  }

  static Map<String, int> _topFrequencies(List<String> words, int topN) {
    final freq = <String, int>{};
    for (final w in words) {
      freq[w] = (freq[w] ?? 0) + 1;
    }
    final sorted = freq.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top = <String, int>{};
    for (var i = 0; i < min(topN, sorted.length); i++) {
      top[sorted[i].key] = sorted[i].value;
    }
    return top;
  }

  static int _countSyllablesInWords(List<String> words) {
    var total = 0;
    for (final w in words) {
      total += _countSyllables(w);
    }
    return total;
  }

  static int _countSyllables(String word) {
    // Very simple heuristic for syllables: count vowel groups
    final cleaned = word.toLowerCase().replaceAll(RegExp(r"[^a-zà-ÿ']"), '');
    if (cleaned.isEmpty) return 0;
    final matches = RegExp(r'[aeiouyàáâãäåæèéêëìíîïòóôõöùúûüýÿ]+').allMatches(cleaned);
    var count = matches.length;
    // Adjustments: silent 'e' at the end
    if (cleaned.endsWith('e') && count > 1) count -= 1;
    if (count == 0) count = 1;
    return count;
  }

  static double _fleschReadingEase(int words, int sentences, int syllables) {
    if (words == 0 || sentences == 0) return 0.0;
    final wPerS = words / sentences;
    final sPerW = syllables / words;
    return 206.835 - (1.015 * wPerS) - (84.6 * sPerW);
  }
}
