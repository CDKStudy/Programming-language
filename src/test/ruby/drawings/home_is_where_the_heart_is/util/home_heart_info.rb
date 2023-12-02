require_relative '../../../../../core/ruby/snapshot/eval_text_image_sub_path_pair'
require_relative '../../../../../main/ruby/drawings/home_is_where_the_heart_is/heart'
require_relative '../../../../../main/ruby/drawings/home_is_where_the_heart_is/home'

class HomeHeartInfo
  def eval_text_image_sub_path_pairs(is_complete: true)
    [EvalTextImageSubPathPair.new('Home.new() # note: does NOT need to be exact match', 'Home'),
     EvalTextImageSubPathPair.new('Heart.new() # note: does NOT need to be exact', 'Heart'),]
  end
end