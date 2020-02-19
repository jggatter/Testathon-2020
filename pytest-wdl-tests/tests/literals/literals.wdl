# This workflow tests the the literals sections of the WDL 1.0 Spec
# It also requires the use of some functions such as write_lines(), write_object(), write_map(), and stdout()
# write_map() is slightly broken as it does not print a \n after writing like the related functions do.

version 1.0

workflow literals {
	input {
		### Array Literals
		Array[String] array_literal_strings = ["array", "literal"]
		Array[Int] array_literal_ints = [0, 1, 2]

		### Map Literals
		Map[Int, Int] map_literal_ints = {1: 10, 2: 11}
		Map[String, Int] map_literal_mixed = {"a": 1, "b": 2}

		### Object Literals
		Object object_literal = object {
			a: 10,
			b: 11
		}

		### Object Coercion from Map
		# "object" keyword before {} indicates Object, absence of indicates Map.
		String key1 = "key1name"
		String key2 = "key2name"
		String key3 = "key3name"

		Object object_syntax = object {
			key1: 7,
			key2: 8,
			key3: 9
		}

		Object map_coercion = {
			key1: 10,
			key2: 11,
			key3: 12
		}

		### Pair Literals
		Pair[Int, String] pair_literal_mixed = (23, "twenty-three")
	}
	call array_literals {
		input:
			array_literal_strings=write_lines(array_literal_strings),
			array_literal_ints=write_lines(array_literal_ints)
	}
	call map_literals {
		input:
			map_literal_ints=write_map(map_literal_ints),
			map_literal_mixed=write_map(map_literal_mixed)
	}
	call object_literals {
		input:
			object_literal = write_object(object_literal)
	}
	call object_map_coercion {
		input:
			object_syntax=write_object(object_syntax),
			map_coercion=write_object(map_coercion)
	}
	call pair_literals {
		input:
			pair_literal_mixed_left=pair_literal_mixed.left,
			pair_literal_mixed_right=pair_literal_mixed.right
	}
	output {
		File array_literals_out = array_literals.array_literals_out
		File map_literals_out = map_literals.map_literals_out
		File object_literals_out = object_literals.object_literals_out
		File object_map_coercion_out = object_map_coercion.object_map_coercion_out
		File pair_literals_out = pair_literals.pair_literals_out
	}
}

task array_literals {
	input {
		File array_literal_ints
		File array_literal_strings
	}
	command {
		set -e
		echo INTS
		cat ~{array_literal_ints}
		printf "STRINGS\n"
		cat ~{array_literal_strings}
	}
	output {
		File array_literals_out = stdout()
	}
}

task map_literals {
	input {
		File map_literal_ints
		File map_literal_mixed
	}
	command {
		set -e
		
		echo INTS
		cat ~{map_literal_ints}
		printf "\nMIXED\n"
		cat ~{map_literal_mixed}
	}
	output {
		File map_literals_out = stdout()
	}
}

task object_literals {
	input {
		File object_literal
	}
	command {
		set -e
		
		cat ~{object_literal}
	}
	output {
		File object_literals_out = stdout()
	}
}

task object_map_coercion {
	input {
		File object_syntax
		File map_coercion
	}
	command {
		set -e

		echo OBJECT_SYNTAX
		cat ~{object_syntax}
		printf "MAP_COERCION\n"
		cat ~{map_coercion}
	}
	output {
		File object_map_coercion_out = stdout()
	}
}

task pair_literals {
	input {
		Int pair_literal_mixed_left
		String pair_literal_mixed_right
	}
	command {
		set -e
		
		echo ~{pair_literal_mixed_left} ~{pair_literal_mixed_right}
	}
	output {
		File pair_literals_out = stdout()
	}
}