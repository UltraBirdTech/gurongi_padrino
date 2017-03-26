Gurongi::App.controllers :gurongi do
  include Gurongi
  
  get :index do
    GURONGI_MAP = YAML.load_file(Padrino.root("/lib/mapping_table.yml"))
    FILTER_WORDS = YAML.load_file(Padrino.root("/lib/filter_words.yml"))
    str_jp = params[:word]
    ext_poiints = search_exception_points(str_jp)
p str_jp 
    
    result_array = translate_gurongi(ext_poiints, str_jp).join
    result_array
  end

end
