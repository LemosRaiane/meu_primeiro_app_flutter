import 'package:flutter/material.dart';

import '../services/text_analyzer.dart';
import '../models/analysis_result.dart';
import '../widgets/results_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  AnalysisResult? _result;
  bool _busy = false;

  void _analyze() {
    final text = _controller.text;
    setState(() => _busy = true);
    Future.delayed(const Duration(milliseconds: 50), () {
      final res = TextAnalyzer.analyze(text);
      setState(() {
        _result = res;
        _busy = false;
      });
    });
  }

  void _clear() {
    _controller.clear();
    setState(() => _result = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analisador de Texto')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Cole ou digite o texto aqui...',
                ),
                keyboardType: TextInputType.multiline,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _busy ? null : _analyze,
                    icon: const Icon(Icons.analytics),
                    label: Text(_busy ? 'Analisando...' : 'Analisar'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _clear,
                  icon: const Icon(Icons.clear),
                  label: const Text('Limpar'),
                ),
              ],
            ),
            if (_result != null) ResultsCard(result: _result!),
          ],
        ),
      ),
    );
  }
}
