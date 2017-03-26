Gurongi::App.controllers :translate do
  include GurongiTranslate
  before do
    @translate = {}
  end

  get :index do
    @gurongi = ''
    render 'translate/index'
  end

  post :index do
    @str_jp = params['hash']['translate']
    @gurongi = translate_ja_to_gr(@str_jp)
    render 'translate/index'
  end

end
