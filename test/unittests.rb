require 'test/unit'
require '../lenaparser'

class StringTest < Test::Unit::TestCase

  def setup
   @file = File.new("/Users/nigel/Desktop/lena_01/test/LENA_DL_B03_F014_2.txt", 'r')
   @string = "Ich weiß, (more) ich… ich hab (stuff) mich zuerst?! naja verhalten!!!??? Ich musste!! Naja auch erstmal alles verarbeiten… Aber jetzt…"
   @lenaparser = LenaParser.new(@file, "LENA_DL_B03_F014_2.txt")
   @string_clean = "Ich weiß, ich. ich hab mich zuerst? na ja verhalten? Ich musste. Na ja auch erstmal alles verarbeiten. Aber jetzt."
  end
  
  def test_clean_string_pos
    assert_equal(@string_clean, @lenaparser.clean_text(@string))
  end
  
  def test_split_on_sentences
    text = @lenaparser.clean_text(@string)
    array = @lenaparser.split_on_sentences("1. NAME", text)
    assert_equal(6, array.length)
  end
  
  def test_number_of_subtitles
    assert_equal(619, @lenaparser.dialogs.length)
  end
  
  def test_name_of_subtitle_no3
    assert_equal("LENA", @lenaparser.dialogs[3].speaker)
  end
  
  def test_batch_subs
    result = ["Ich weiß, ich.","ich hab mich zuerst?","na ja verhalten?","Ich musste.","Na ja auch erstmal alles verarbeiten.","Aber jetzt."]
    text = @lenaparser.clean_text(@string)
    array = @lenaparser.split_on_sentences("1. NAME", text)
    assert_equal(result, @lenaparser.batch_subs("1. NAME", array))
  end
  
end