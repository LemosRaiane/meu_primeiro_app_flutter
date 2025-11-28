class AnalysisResult {
  final int charCountWithSpaces;
  final int charCountWithoutSpaces;
  final int wordCount;
  final int sentenceCount;
  final double avgWordsPerSentence;
  final double fleschReadingEase;
  final double estimatedReadingMinutes;
  final Map<String, int> topWords;
  final int syllableCount;

  AnalysisResult({
    required this.charCountWithSpaces,
    required this.charCountWithoutSpaces,
    required this.wordCount,
    required this.sentenceCount,
    required this.avgWordsPerSentence,
    required this.fleschReadingEase,
    required this.estimatedReadingMinutes,
    required this.topWords,
    required this.syllableCount,
  });

  Map<String, dynamic> toMap() => {
        'charWithSpaces': charCountWithSpaces,
        'charWithoutSpaces': charCountWithoutSpaces,
        'words': wordCount,
        'sentences': sentenceCount,
        'avgWordsPerSentence': avgWordsPerSentence,
        'fleschReadingEase': fleschReadingEase,
        'estimatedReadingMinutes': estimatedReadingMinutes,
        'topWords': topWords,
        'syllableCount': syllableCount,
      };
}
