require_relative '../../../../core/ruby/snapshot/test_snapshots_web_page_generator'
require_relative '../util/branch_info'

gen = TestSnapshotsWebPageGenerator.new(BranchInfo.new, "./branch_test.html", "Render Branch", "branch", is_diff_desired: false, snapshot_generator: SnapshotGenerator.new(width: 400, height: 400, clear_color: Color::WHITE))
gen.generate
gen.teardown