import 'package:flutter/material.dart';

import '../models/analysis_result.dart';

class ResultsCard extends StatelessWidget {
  final AnalysisResult result;

  const ResultsCard({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row('Caracteres (com espaços):', result.charCountWithSpaces.toString()),
            _row('Caracteres (sem espaços):', result.charCountWithoutSpaces.toString()),
            _row('Palavras:', result.wordCount.toString()),
            _row('Frases:', result.sentenceCount.toString()),
            _row('Média palavras/frase:', result.avgWordsPerSentence.toString()),
            _row('Sílabas (est.):', result.syllableCount.toString()),
            _row('Flesch Reading Ease:', result.fleschReadingEase.toString()),
            _row('Tempo leitura (min):', result.estimatedReadingMinutes.toString()),
            const SizedBox(height: 8),
            const Text('Top palavras:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: result.topWords.entries
                  .map((e) => Chip(label: Text('${e.key} (${e.value})')))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.bold))],
        ),
      );
}
