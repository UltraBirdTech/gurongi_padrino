Gurongi::App.controllers :translate do
  before do
    GURONGI_MAP = YAML.load_file(Padrino.root("/lib/mapping_table.yml"))
    FILTER_WORDS = YAML.load_file(Padrino.root("/lib/filter_words.yml"))
    @translate = {}
  end

  get :index do
    @gurongi = ''
    render 'translate/index'

  end

  post :index do
    str_jp = params['hash']['translate']
    ext_poiints = search_exception_points(str_jp)
    @gurongi = translate_gurongi(ext_poiints, str_jp).join
    render 'translate/index'
  end

end
