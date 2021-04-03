# System calls

The SYS instruction takes the system call in r0, and additional parameters in r1, r2, ..

* #0 - print the current process to stdout
* #1 - print a string in pointed by r1 to stdout
* #2 - convert integer from r1 to string and place it in address pointed by r2
* #3 - convert string from address pointed by r1 to integer, and return it in r0
* #4 - open file with filename (string) from address pointed by r1, flags in r2 (bit#0 = create if the file doesn't exist), returns file handle in r0, negative value means error
* #5 - close file, takes the file handle in r1
* #6 - io control, see IO Control Operations below for more information
* #7 - the process is put into sleep until one or more signal(s) specified in r1 arrive, returns the signals in r0, signals (bit numbers):
  * #4 - IO ready, takes number of files in r2, and pointer to array of file handles in r3
* #8 - read the realtime clock and return the seconds in r0, and fractions in r1, resolution is 1/1000 seconds, this is game time and not real life seconds
* #9 - read file, r1 = file handle, r2 = pointer to memory buffer, r3 = number of bytes to read, returns the number of bytes read in r0, zero bytes read = eof
* #10 - write file, r1 = file handle, r2 = pointer to memory buffer, r3 = number of bytes to write, returns 0 upon success in r0
* #11 - seek file, r1 = file handle, r2 = whence (0=set, 1=current, 2=end), r3=offset, returns 0 upon success in r0


## IO Control Operations

Takes the target file handle in r1 register, and the operation specifier in r2.

### r2=0 Set state 
Set the state of the device file to the given parameter in r3.

