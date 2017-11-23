module PadrinoApp
  # yamlファイルからマッピングデータを読み込む
  class MappingTable
    Mapping = YAML.load_file(Padrino.root('/lib/mapping_table.yml'))

    def self.[](key)
      Mapping[key]
    end
  end
end
