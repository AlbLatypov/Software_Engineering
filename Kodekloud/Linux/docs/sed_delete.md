# SED delete lines

To delete all lines containing the word "software" (case-insensitive) from a file and save the results in /home/BSD_DELETE.txt, you can use the following sed command:

`sed '/software/Id' input_file > /home/BSD_DELETE.txt`

Here's a breakdown of the command:

- sed is the stream editor utility in Unix/Linux systems.
    'pattern' is the pattern to search for. 
- In this case, `/software/I` is a regular expression that matches the word "software" in a case-insensitive manner (the I flag makes the search case-insensitive).
- `d` is the command to delete the matching lines.
