require_relative '../lib/string_to_gr'

RSpec.describe String do
  class TestClass
    include GurongiTranslate
  end

  describe 'transalte_ja_to_gr' do
    let(:gurongi) { TestClass.new }
    context '正常系' do
      it '「ガギグゲゴ」が返却されること' do
        expect(gurongi.translate_ja_to_gr('あいうえお')).to eq 'ガギグゲゴ'
      end
      
      it '小字を変換できること' do
        expect(gurongi.translate_ja_to_gr('ちゃ')).to eq 'ジャ'
      end

      it '「ー」は前の文字が重ねられること' do
        expect(gurongi.translate_ja_to_gr('ライダー')).to eq 'サギザザ'
      end

      it '「っ」は後の文字が重ねられること' do
        expect(gurongi.translate_ja_to_gr('キック')).to eq 'ビブブ'
      end
      
      it '例外単語は例外処理されて文字列が返却されること' do
        expect(gurongi.translate_ja_to_gr('カメンライダークウガ')).to eq 'バレンサギザザクウガ'
      end
    end

    context '異常系' do
      it '「*」のみの場合' do
        expect(gurongi.translate_ja_to_gr('*')).to eq 'ここではリントの言葉を話せ'
      end

      it '「*」が文字列に含まれている場合' do
        expect(gurongi.translate_ja_to_gr('ほげ*もげ')).to eq 'ここではリントの言葉を話せ'
      end


      it '「っ」のみの場合' do
        expect(gurongi.translate_ja_to_gr('っ')).to eq 'ここではリントの言葉を話せ'
      end
      it '「ー」のみの場合' do
        expect(gurongi.translate_ja_to_gr('ー')).to eq 'ここではリントの言葉を話せ'
      end
      it 'ゃのみの場合' do
        expect(gurongi.translate_ja_to_gr('ゃ')).to eq 'ここではリントの言葉を話せ'
      end
      it '変換できない文字の場合' do
        expect(gurongi.translate_ja_to_gr('a')).to eq 'ここではリントの言葉を話せ'
      end
    end
  end

  describe 'exclution_words' do
    let(:gurongi) { TestClass.new }
    context '正常系' do
      it '除外文字が*に変換され、除外単語の情報が配列形式で変換されること' do
        expect(gurongi.exclution_words('クウガ')).to eq ['*', ['クウガ']]
      end
      it '除外文字が*に変換され、除外単語の情報が配列形式で変換されること' do
        expect(gurongi.exclution_words('クウガとダグバ')).to eq ['*と*', ['クウガ', 'ダグバ']]
      end
    end
  end

  describe 'reverse_exclution_words' do
    let(:gurongi) { TestClass.new }
    context '正常系' do
      it '配列の情報から除外単語が復元されていること' do
        expect(gurongi.reverse_exclution_words('*', ['クウガ'])).to eq 'クウガ'
      end
      it '二つ以上の単語が復元されること' do
        expect(gurongi.reverse_exclution_words('*ド*', ['クウガ','ダグバ'])).to eq 'クウガドダグバ'
      end
    end
  end
end
