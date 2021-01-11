The SYS instruction takes the system call in r0, and additional parameters in r1, r2, ..

[list]
[*] #0 - print the current process to stdout
[*] #1 - print a string in pointed by r1 to stdout
[*] #2 - convert integer from r1 to string and place it in address pointed by r2
[*] #3 - convert string from address pointed by r1 to integer, and return it in r0
[*] #4 - open file with filename (string) from address pointed by r1, returns file handle in r0, negative value means error
[*] #5 - close file, takes the file handle in r1
[*] #6 - io control, takes file handle in r1, operation in r2, and parameter in r3, valid operations:
[list]
[*] #0 - set the state of the device file to the given parameter
[/list]
[/list]
