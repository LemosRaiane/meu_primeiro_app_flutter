# Aplicativo Analisador de Texto

Este repositório contém um aplicativo Flutter simples para analisar texto (contagem de palavras, frases, sílabas estimadas, índice Flesch, top palavras, etc.).

Prerequisitos
- Flutter SDK instalado (recomenda-se versão estável recente). Veja: https://flutter.dev/docs/get-started/install

Como usar (Windows PowerShell)

Instale as dependências:
```powershell
flutter pub get
```

Executar o app (emulador ou dispositivo conectado):
```powershell
flutter run
```

Rodar testes unitários:
```powershell
flutter test
```

Arquivos-chave
- `lib/main.dart` - ponto de entrada
- `lib/screens/home_screen.dart` - UI principal
- `lib/services/text_analyzer.dart` - lógica de análise de texto
- `lib/models/analysis_result.dart` - modelo de resultado
- `lib/widgets/results_card.dart` - widget de exibição dos resultados

Observações
- A análise usa heurísticas simples e é adequada para propósitos educacionais e prototipagem.
# meu_primeiro_app_flutter

commit inicial