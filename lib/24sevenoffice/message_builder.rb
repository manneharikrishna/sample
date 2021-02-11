class TwentyFourSevenOffice::MessageBuilder
  def self.build(template, assigns)
    new(template, assigns).send(:build)
  end

  def initialize(template, assigns)
    @template = template
    @view = ActionView::Base.new(context, assigns)
  end

  private

  attr_reader :template
  attr_reader :view

  def build
    file_name = "#{template}.xml.erb"
    Nori.new.parse(view.render(file: file_name))
  end

  def context
    ActionView::PathSet.new([TwentyFourSevenOffice.config.xml_view_path])
  end
end
