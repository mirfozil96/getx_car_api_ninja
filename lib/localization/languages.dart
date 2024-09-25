class LanguageModel {
  final String language;
  final String languageNameInEnglish;
  final String symbol;
  final String icon;
  LanguageModel(
      this.language, this.languageNameInEnglish, this.symbol, this.icon);
}

List<LanguageModel> appLanguages = [
  LanguageModel("Uzbek", "Uzbek", "uz", "uz"),
  LanguageModel("Русский", "Russian", "ru", "ru"),
];
