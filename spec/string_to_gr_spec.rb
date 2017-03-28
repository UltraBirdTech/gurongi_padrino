require_relative '../lib/string_to_gr'

RSpec.describe String do
  describe 'to_gr' do  
    context '正常系' do
      it '「あ」が「ガ」に変換されること' do
        expect('あ'.to_gr).to eq 'ガ'
      end
      
      it '「きゃ」が「キャ」に変換されること' do
        expect('きゃ'.to_gr).to eq 'キャ'
      end
     
      it '「ふぁ」が「ザ」に変換されること' do
        expect('ふぁ'.to_gr).to eq 'ザ'
      end
     
      it '「だ」が「ザ」に変換されること' do
        expect('だ'.to_gr).to eq 'ザ'
      end
      
      it 'nilが返却されること' do
       expect('a'.to_gr).to eq nil
      end
    end
  end

  describe 'to_gr!' do
    context '正常系' do
      it '「あ」が「ガ」に変換される変換されること' do
        expect('あ'.to_gr).to eq 'ガ'
      end
    end

    context '異常系' do
      xit 'エラーが発生すること' do
        expect('a'.to_gr!).to raise_error('Faile to translate ja to gr')
      end
    end
  end
end
