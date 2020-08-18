# What is it

A text interpreter for windows command line ***cmd/powershell***.

<img src="file:///home/fatih/Downloads/Showcase.gif" title="" alt="" width="971">



# USAGE

#### There are four options for file operation:

- Reading

- Writing

- Changing
  
  and

- Deleting



#### In your notes you can use these commands:

- ###### *#color [args] (ex: color 4f)*
  
  Changes the color of the terminal. If no arguments given it will display the available colors.

- ###### *#pause*
  
  Pauses the writing until a key press. (Can be used for multiple color sections or paging the text.)
  
  ###### *#new*
  
  Prints blank line. (Blank lines In the note files are not read. So this command must be used for printing those lines.)

- ###### *#line*
  
  Prints "-" to the end of line.

- ###### *#slash*
  
  Prints "/" to the end of line.

- ###### *#dots*
  
  Prints "." to the end of line.

- ###### *#star*
  
  Prints "*" to the end of line.

##### Note: Commands are case sensitive and must be aligned left.



# WHY

I had free time and was looking for a project then this happened. ;)

# 

# Warning!

Do not uncomment `CHCP 65001`.  This line makes crash. Because of this issue program does not support Utf-8.
