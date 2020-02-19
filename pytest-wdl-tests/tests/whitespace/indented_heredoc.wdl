# This workflow has tab indents and one extra indent at the heredoc! It is intended to fail miserably.

version 1.0

workflow indented_heredoc {
	input {
		String message = "I am a document. I am indented incorrectly at the heredoc. Let me fail!"
	}
	call t {
		input: message=message
	}
	output {
		File indented_heredoc_out = t.out
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