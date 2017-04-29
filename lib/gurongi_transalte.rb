module GurongiTranslate
  ###########################
  # 翻訳メソッド
  # 日本語の文字列を受け取り、グロンギ語の文字列を返却する
  # 引数: ja_str (日本語の文字列)
  # 返値: gr_str (グロンギ語の文字列)
  def translate_ja_to_gr (ja_str)

    # '*'は特別な意味を持つためreturnする
    if ja_str.match('\*')
      return 'ここではリントの言葉を話せ'
    end
    
    # TODO: to_kanaでja_strは全てカタカナ表記にしてしまう。
    ja_str_extra_word, extra_word_array = exclution_words(ja_str)

    gr_str = ''

    begin
      ja_str_extra_word.each_char.with_index do |c, i|
        case c
        when '*'
          # *を追加する
          gr_str << '*'
        when 'ゃ', 'ャ', 'ゅ', 'ュ', 'ょ', 'ョ', 'ぁ', 'ァ', 'ぃ', 'ィ', 'ぇ', 'ェ', 'ぉ', 'ォ' 
          # 一文字前の文字を含めて再変換する
          # 「しゃ」の場合は、「ゃ」で検知して一文字前で翻訳済みの「し」を含めて「しゃ」として翻訳し直す
          gr_str[-1] = (ja_str_extra_word[i - 1] + c).to_gr!
        when 'ー'
          # 前の文字を重ねる
          gr_str << gr_str[-1]
        when 'っ', 'ッ'
          # 後の文字を重ねる
          gr_str << ja_str_extra_word[i + 1].to_gr!
        else
          gr_str << c.to_gr!
        end
      end
    rescue => e
      p "Failer: Can't change ja to gr. error string is #{ja_str}." 
      return 'ここではリントの言葉を話せ'
    end

    if extra_word_array
      gr_str = reverse_exclution_words(gr_str, extra_word_array)
    end

    gr_str
  end

  private
  ##########################
  # 除外単語変換メソッド
  # FILTER_WORDSに存在する単語を一時的に'*'に置き換える。
  # 除外する単語の配列を保持する
  def exclution_words(ja_str)
    extra_word_array = []
    PadrinoApp::FilterWords::FILTER_WORDS.each do |extra_word|
      if ja_str.include?(extra_word)
        extra_word_array << extra_word
        ja_str.sub!(extra_word, '*')
      end
    end

    [ja_str, extra_word_array]
  end

  ##########################
  # 除外単語を復元するメソッド
  # excluetion_wordsで一時的に置き換えた文字を復元する。
  def reverse_exclution_words(gr_str, extra_word_hash)
    extra_word_hash.each do |value|
      gr_str.sub!('*', value)
    end
    gr_str
  end
end
