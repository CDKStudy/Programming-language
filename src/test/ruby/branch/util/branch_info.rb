require_relative '../../../../core/ruby/snapshot/eval_text_image_sub_path_pair'
require_relative '../../../../main/ruby/branch/branch'

class BranchInfo
  def eval_text_image_sub_path_pairs(is_complete: true)
    (0..5).map do |i|
      EvalTextImageSubPathPair.new("Branch.new(max_depth: #{i}) # note: does NOT need to be exact match but should look like a branch", "Branch#{i}")
    end
  end
end