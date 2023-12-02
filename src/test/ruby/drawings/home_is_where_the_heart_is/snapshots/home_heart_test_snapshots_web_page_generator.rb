require_relative '../../../../../core/ruby/snapshot/test_snapshots_web_page_generator'
require_relative '../util/home_heart_info'

gen = TestSnapshotsWebPageGenerator.new(HomeHeartInfo.new, "./home_heart_test.html", "Render Home Heart", "home_is_where_the_heart_is",
                                        is_diff_desired: false,
                                        snapshot_generator: SnapshotGenerator.new(clear_color: Color.from_unsigned_bytes(108, 115, 115)))
gen.generate
gen.teardown

