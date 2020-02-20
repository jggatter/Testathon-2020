import pytest
import pytest_wdl

# Takes about two minutes to run all tests.

# All these should pass
def test_spaces(workflow_data, workflow_runner):
	expected = workflow_data.get_dict("spaces_out")
	workflow_runner("spaces.wdl", expected=expected)

def test_tabs(workflow_data, workflow_runner):
	expected = workflow_data.get_dict("tabs_out")
	workflow_runner("tabs.wdl", expected=expected)

def test_calls_to_differently_indented_subworkflows(workflow_data, workflow_runner):
	expected = workflow_data.get_dict("tabs_out", "spaces_out")
	workflow_runner("proper_whitespace.wdl", expected=expected)

# All below should fail
def test_mixed_fails(workflow_data, workflow_runner):
	with pytest.raises(pytest_wdl.ExecutionFailedError) as err:
		workflow_runner("mixed.wdl")
