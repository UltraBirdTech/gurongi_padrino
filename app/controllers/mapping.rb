Gurongi::App.controllers :mapping do
  before do
    GURONGI_MAP = YAML.load_file(Padrino.root("/lib/mapping_table.yml"))
    FILTER_WORDS = YAML.load_file(Padrino.root("/lib/filter_words.yml"))
    @translate = {}
  end

  get :index do
    render 'mapping/index'
  end
end
