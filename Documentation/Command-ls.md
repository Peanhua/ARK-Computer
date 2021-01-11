# Command: ls

The "ls" command takes optional argument, the directory to list. Without arguments it lists the current directory (which currently can't be changed and is the root directory).

Examples:
```
ls
ls bin
ls dev
```

The output contains one row for each file, and the columns are from left to right:
* Filetype: D=Directory, X=Executable, T=Text file, O=Object file, F=Other
* Size in bytes
* Name of the file

The built-in files, directories, and device files, all have size of 0.
