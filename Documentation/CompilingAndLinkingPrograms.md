# Compiling and linking programs

The process is the standard compile and then link. Use the scanner to create a source file, and then compile it with the "as" command. The command takes two parameters, the name of the input source file containing assembler instructions, and the name of the output file, which will contain the object file:
```
as myprog.s myprog.o
```


Then link the object file to create an executable. Currently all executables must be located in /bin -directory in order for you to be able to run them. For example:
```
ld myprog.o bin/myprog
```

And now you should be able to run your program:
```
myprog
```
