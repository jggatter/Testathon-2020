version 1.0

workflow basic_array_functions {
	input {
		File tsv
		Int num = 3 # range(num) --> [0, 1, 2]
		Array[Int] array_1 = [0, 1, 2]
		Array[Int] array_2 = [3, 4, 5]
		Array[String] array_3 = ['a', 'b', 'c']
		Array[String] array_4 = ['d', 'e']
	}
	# tsv is read into a 2D array before it is fed to transpose and flatten
	Array[Array[String]] array_2d = read_tsv(tsv)
	
	call range {
		input: array_range=range(num)
	}
	call transpose {
		input: array_transpose=transpose(array_2d)
	}
	scatter (pair in zip(array_1, array_3)) {
		call zip {
			input:
				pair_left=pair.left,
				pair_right=pair.right
		}
	}
	scatter (pair in cross(array_1, array_4)) {
		call cross {
			input:
				pair_left=pair.left,
				pair_right=pair.right
		}
	}
	call length {
		input: 
			array_1_length=length(array_1),
			array_4_length=length(array_4)
	}
	call flatten {
		input: array_flatten=flatten(array_2d)
	}
	call prefix {
		input: array_prefix=prefix("prefix_", array_3)
	}
	output {
		File range_out = range.out
		File transpose_out = transpose.out
		Array[File] zip_out = zip.out
		Array[File] cross_out = cross.out
		File length_out = length.out
		File flatten_out = flatten.out
		File prefix_out = prefix.out
	}
}

task range {
	input {
		Array[Int] array_range
	}
	command {
		cat ~{write_lines(array_range)}
	}
	output {
		File out = stdout()
	}
	runtime {
		docker: "ubuntu:latest"
	}
}

task transpose {
	input {
		Array[Array[String]] array_transpose
	}
	command {
		cat ~{write_tsv(array_transpose)}
	}
	output {
		File out = stdout()
	}
	runtime {
		docker: "ubuntu:latest"
	}
}

task zip {
	input {
		Int pair_left
		String pair_right
	}
	command {
		echo ~{pair_left} ~{pair_right}
	}
	output {
		File out = stdout()
	}
	runtime {
		docker: "ubuntu:latest"
	}
}

task cross {
	input {
		Int pair_left
		String pair_right
	}
	command {
		echo ~{pair_left} ~{pair_right}
	}
	output {
		File out = stdout()
	}
	runtime {
		docker: "ubuntu:latest"
	}
}

task length {
	input {
		Int array_1_length
		Int array_4_length
	}
	command {
		echo ~{array_1_length} # 3
		echo ~{array_4_length} # 2
	}
	output {
		File out = stdout()
	}
	runtime {
		docker: "ubuntu:latest"
	}
}

task flatten {
	input {
		Array[String] array_flatten
	}
	command {
		cat ~{write_lines(array_flatten)}
	}
	output {
		File out = stdout()
	}
	runtime {
		docker: "ubuntu:latest"
	}
}

task prefix {
	input {
		Array[String] array_prefix
	}
	command {
		cat ~{write_lines(array_prefix)}
	}
	output {
		File out = stdout()
	}
	runtime {
		docker: "ubuntu:latest"
	}
}