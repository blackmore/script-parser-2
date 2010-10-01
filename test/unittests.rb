require 'test/unit'
require '../lenaparser'

class StringTest < Test::Unit::TestCase

  def setup
   @file = File.new("/Users/nigel/Desktop/lena_01/test/LENA_DL_B03_F014_2.txt", 'r')
   @string = "Ich weiß, (more) ich… ich hab (stuff) mich zuerst doof verhalten… Ich musste das auch erstmal alles verarbeiten… Aber jetzt…"
   @lenaparser = LenaParser.new(@file, "LENA_DL_B03_F014_2.txt")
   @string_clean = "Ich weiß, ich__* ich hab mich zuerst doof verhalten__* Ich musste das auch erstmal alles verarbeiten__* Aber jetzt__*"
  end
  
  def test_clean_string_pos
    assert_equal(@string_clean, @lenaparser.clean_text(@string))
  end
  
  def test_split_on_sentences
    text = @lenaparser.clean_text(@string)
    array = @lenaparser.split_on_sentences("1. NAME", text)
    assert_equal(2, array.length)
  end
  
end