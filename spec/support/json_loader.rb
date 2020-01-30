require 'ostruct'

module JSONLoader
  def load_fixture(filename)
    load_json(File.expand_path("spec/fixtures/#{filename}"))
  end

  def load_json(filename)
    JSON.parse(File.read(filename), object_class: OpenStruct)
  end
end
