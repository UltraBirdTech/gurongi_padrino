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
      gr_str = translate_ja_str(ja_str_extra_word)
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
  # 日本語文字列をグロンギ語文字列に変換するメソッド
  def translate_ja_str(ja_str_extra_word)
    gr_str = ''
    ja_str_extra_word.each_char.with_index do |c, i|
        case c
        when '*'
         gr_str << '*' # *を追加する
        when 'ゃ', 'ャ', 'ゅ', 'ュ', 'ょ', 'ョ', 'ぁ', 'ァ', 'ぃ', 'ィ', 'ぇ', 'ェ', 'ぉ', 'ォ'
          gr_str[-1] = translate_small_chars(ja_str_extra_word, i ,c)
        when 'ー'
          gr_str << gr_str[-1] # 前の文字を重ねる
        when 'っ', 'ッ'
          gr_str << ja_str_extra_word[i + 1].to_gr! # 後の文字を重ねる
        else
          gr_str << c.to_gr!
        end
      end
    gr_str
  end

  ##########################
  # 小文字の変換を行うメソッド
  # 一文字前の文字を含めて再変換する
  # 「しゃ」の場合は、「ゃ」で検知して一文字前で翻訳済みの「し」を含めて「しゃ」として翻訳し直す
  # ja_str_extra_word: 除外単語を*に変換した後の日本語文字列
  # i: 文字列のindex
  # c: 変換対象の文字
  def translate_small_chars(ja_str_extra_word, i, c)
    (ja_str_extra_word[i - 1] + c).to_gr!
  end

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
