class String

  ######################################
  # 日本文字に対応するグロンギ文字を返却する
  # 対応する文字がない場合はnilを返却
  def to_gr
    PadrinoApp::MappingTable[self]
  end

 ######################################
  # 日本文字に対応するグロンギ文字を返却する
  # 対応する文字がない場合はerror 
  def to_gr!
    raise 'Faile to translate ja to gr' unless (c = PadrinoApp::MappingTable[self])

    c
  end
end

