import pytest
import pytest_wdl

# Takes about two minutes to run all tests.

# All should pass
def test_spaces(workflow_data, workflow_runner):
	inputs = {}
	expected = workflow_data.get_dict("spaces_out")
	workflow_runner("spaces.wdl", inputs, expected)

def test_tabs(workflow_data, workflow_runner):
	inputs = {}
	expected = workflow_data.get_dict("tabs_out")
	workflow_runner("tabs.wdl", inputs, expected)

def test_calls_to_differently_indented_subworkflows(workflow_data, workflow_runner):
	inputs = {}
	expected = workflow_data.get_dict("tabs_out", "spaces_out")
	workflow_runner("proper_whitespace.wdl", inputs, expected)

# All below should fail
def test_mixed(workflow_data, workflow_runner):
	inputs = {}
	#expected = workflow_data.get_dict("mixed_out")
	with pytest.raises(pytest_wdl.ExecutionFailedError) as err:
		workflow_runner("mixed.wdl", inputs)

def test_indented_heredoc(workflow_data, workflow_runner):
	inputs = {}
	#expected = workflow_data.get_dict("mixed_out")
	with pytest.raises(pytest_wdl.ExecutionFailedError) as err:
		workflow_runner("indented_heredoc.wdl", inputs)