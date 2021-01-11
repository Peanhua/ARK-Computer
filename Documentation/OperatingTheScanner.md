[b]Operating the scanner[/b]

If the scanner is discovered by the computer, you should have a device file in the /dev -directory, named scanner0 for the first scanner, scanner1 for the second, etc.

If you name the scanner, you can see what device file corresponds to what name using the "dmesg" command.

Write something to a note paper and place it inside the scanner. Then in the computer, use the "scan" command to scan the note paper and save its contents to a file. The command takes two arguments, first is the name of the device file pointing to the scanner, and second is the name of the output file.

For example:
[code]
scan /dev/scanner0 hello.txt
[/code]

Wait for the scanner to finish, and you can then see the contents with the "cat" command:
[code]
cat hello.txt
[/code]

Other than note papers may also produce output, the scanner reads a variable named "custom item description" from the item.
