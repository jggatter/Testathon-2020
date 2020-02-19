# This workflow has 2-space indents and one tab at the heredoc! It is intended to fail miserably.

version 1.0

workflow mixed {
  input {
    String message = "I am a document. I am mixed. Let me fail!"
  }
  call t {
    input: message=message
  }
  output {
    File mixed_out = t.out
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