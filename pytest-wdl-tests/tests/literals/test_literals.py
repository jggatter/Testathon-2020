def test_literals(workflow_data, workflow_runner):
	inputs = {}
	expected = workflow_data.get_dict("array_literals_out", "map_literals_out", "object_literals_out", "object_map_coercion_out", "pair_literals_out")
	workflow_runner("literals.wdl", inputs, expected, workflow_name="literals")