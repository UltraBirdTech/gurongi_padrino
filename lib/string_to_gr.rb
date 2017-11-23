# String Classを拡張して、グロンギ文字とひらがなをマッピングするクラス
class String
  # 日本文字に対応するグロンギ文字を返却する
  # 対応する文字がない場合はnilを返却
  def to_gr
    PadrinoApp::MappingTable[self]
  end

  # 日本文字に対応するグロンギ文字を返却する
  # 対応する文字がない場合はerror
  def to_gr!
    error_message = 'Faile to translate ja to gr'
    raise error_message unless (c = PadrinoApp::MappingTable[self])

    c
  end
end
