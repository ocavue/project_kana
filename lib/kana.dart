class Kana {
  String hiragana, katakana, romaji;

  Kana(this.hiragana, this.katakana, this.romaji);

  @override
  String toString() {
    return 'Kana(romaji: $romaji)';
  }
}

final kanas = [
  Kana('あ', 'ア', 'a'),
  Kana('い', 'イ', 'i'),
  Kana('う', 'ウ', 'u'),
  Kana('え', 'エ', 'e'),
  Kana('お', 'オ', 'o'),
  Kana('か', 'カ', 'ka'),
  Kana('き', 'キ', 'ki'),
  Kana('く', 'ク', 'ku'),
  Kana('け', 'ケ', 'ke'),
  Kana('こ', 'コ', 'ko'),
  Kana('さ', 'サ', 'sa'),
  Kana('し', 'シ', 'shi'),
  Kana('す', 'ス', 'su'),
  Kana('せ', 'セ', 'se'),
  Kana('そ', 'ソ', 'so'),
  Kana('た', 'タ', 'ta'),
  Kana('ち', 'チ', 'chi'),
  Kana('つ', 'ツ', 'tsu'),
  Kana('て', 'テ', 'te'),
  Kana('と', 'ト', 'to'),
  Kana('な', 'ナ', 'na'),
  Kana('に', 'ニ', 'ni'),
  Kana('ぬ', 'ヌ', 'nu'),
  Kana('ね', 'ネ', 'ne'),
  Kana('の', 'ノ', 'no'),
  Kana('は', 'ハ', 'ha'),
  Kana('ひ', 'ヒ', 'hi'),
  Kana('ふ', 'フ', 'fu'),
  Kana('へ', 'ヘ', 'he'),
  Kana('ほ', 'ホ', 'ho'),
  Kana('ま', 'マ', 'ma'),
  Kana('み', 'ミ', 'mi'),
  Kana('む', 'ム', 'mu'),
  Kana('め', 'メ', 'me'),
  Kana('も', 'モ', 'mo'),
  Kana('や', 'ヤ', 'ya'),
  Kana('ゆ', 'ユ', 'yu'),
  Kana('よ', 'ヨ', 'yo'),
  Kana('ら', 'ラ', 'ra'),
  Kana('り', 'リ', 'ri'),
  Kana('る', 'ル', 'ru'),
  Kana('れ', 'レ', 're'),
  Kana('ろ', 'ロ', 'ro'),
  Kana('わ', 'ワ', 'wa'),
  Kana('を', 'ヲ', 'wo'),
  Kana('ん', 'ン', 'n'),
];
