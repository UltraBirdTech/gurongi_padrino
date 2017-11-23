# String Classの拡張。
# 独自メソッドを定義する。
class String
  # ひらがなをカタカナに変換するメソッド
  def to_kana
    tr('ぁ-ん', 'ァ-ン')
  end

  # カタカナをひらがなに変換するメソッド
  def to_hira
    tr('ァ-ン', 'ぁ-ん')
  end
end
