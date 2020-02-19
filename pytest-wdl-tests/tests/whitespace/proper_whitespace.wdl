# This main workflow is all tab-indented, but it calls both a tab-indented and a 2-space indented subworkflow. 
# It is intended to run successfully.

version 1.0

import "tabs.wdl" as t
import "spaces.wdl" as s

workflow proper_whitespace {
	call t.tabs as tabs
	call s.spaces as spaces
	output {
		File tabs_out = tabs.tabs_out
		File spaces_out = spaces.spaces_out
	}
}
