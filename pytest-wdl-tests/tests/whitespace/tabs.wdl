# This workflow is all tab-indented, it is intended to run successfully.

version 1.0

workflow tabs {
	input {
		String message = "I am a document. I am all tabs. Let me pass!"
	}
	call t {
		input: message=message
	}
	output {
		File tabs_out = t.out
	}
}

task t {
	input {
		String message
	}
	command {
		echo ~{message}
		python <<CODE
		for i in range(0,1):
			print("Look now I'm in this python heredoc! ~{message}")
		CODE
	}
	output {
		File out = stdout()
	}
}