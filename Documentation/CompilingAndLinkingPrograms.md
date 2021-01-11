[b]Compiling and linking programs[/b]

The process is the standard compile and then link. Use the scanner to create a source file, and then compile it with the "as" command. The command takes two parameters, the name of the input source file containing assembler instructions, and the name of the output file, which will contain the object file:
[code]
as myprog.s myprog.o
[/code]

Then link the object file to create an executable. Currently all executables must be located in /bin -directory in order for you to be able to run them. For example:
[code]
ld myprog.o bin/myprog
[/code]

And now you should be able to run your program:
[code]
myprog
[/code]
