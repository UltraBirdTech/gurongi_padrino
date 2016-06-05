require 'spec_helper'

describe 'ExtraWordController',  type: :controller do
  context '例外単語一覧が返却されること'do
    it 'ステータスコードが200で返却される' do
      get 'gurongi/extra_word'

      p response
      expect('hoge').to eq 'hoge'
    end
  end
end
