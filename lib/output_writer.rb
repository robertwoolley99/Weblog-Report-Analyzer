# frozen_string_literal: true

# OutputWriter class which will format arrays from Analyzer
# and write them to files
class OutputWriter
  def initialize(analyzer_object)
    @uv = analyzer_object.uc
    @nuv = analyzer_object.nuc
  end

  def nuv_report
    output = "Non-Unique Views\nURL\t\tCount\n"
    output += build_report(@nuv)
    File.write('non_unique_views.txt', output)
  end

  def uv_report
    output = "Unique Views\nURL\t\tCount\n"
    output += build_report(@uv)
    File.write('unique_views.txt', output)
  end

  private

  def build_report(array)
    output_local = ''
    array.each do |element|
      tab_seperator = tab_string(element[0])
      string = element.each { |p| }.join(tab_seperator)
      output_local += string
      output_local += "\n"
    end
    output_local
  end

  def tab_string(element)
    if element.length > 7
      "\t"
    else
      "\t\t"
    end
  end
end
