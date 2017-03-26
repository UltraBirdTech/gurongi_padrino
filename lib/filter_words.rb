module PadrinoApp
  # yamlファイルからマッピングデータを読み込む
  class FilterWords 
    FILTER_WORDS = YAML.load_file(Padrino.root("/lib/filter_words.yml"))
    
    def self.[](key)
      FILTER_WORDS[key]
    end
  end
end

