def test_basic_array_functions(workflow_data, workflow_runner):
	inputs = {"tsv":workflow_data["colors.tsv"]}
	expected = {
		"range_out":workflow_data["range_out"], 
		"transpose_out":workflow_data["transpose_out"],
		"zip_out": [
			workflow_data["zip_shard_0_out"],
			workflow_data["zip_shard-1_out"],
			workflow_data["zip_shard-2_out"]
		], 
		"cross_out": [
			workflow_data["cross_shard-0_out"],
			workflow_data["cross_shard-1_out"],
			workflow_data["cross_shard-2_out"],
			workflow_data["cross_shard-3_out"],
			workflow_data["cross_shard-4_out"],
			workflow_data["cross_shard-5_out"]
		],
		"length_out":workflow_data["length_out"],
		"flatten_out":workflow_data["flatten_out"],
		"prefix_out":workflow_data["prefix_out"]
	}
	workflow_runner("basic_array.wdl", inputs, expected, workflow_name="basic_array_functions")