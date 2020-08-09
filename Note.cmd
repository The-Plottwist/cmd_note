:: BISMILLAH

@ECHO OFF

SETLOCAL EnableDelayedExpansion

REM Title
TITLE Cmd_Note

REM Utf-8 IF You are using win7 or older comment(REM) this line
CHCP 65001>nul

REM Change Directory
CD C:\Users\%USERNAME%\Documents

REM Check Notes folder
IF NOT EXIST Cmd_Note\ ( MKDIR Cmd_Note )

REM Change Directory
CD Cmd_Note

REM Getting Column number for maximum lenght
SET /A "_line=0"
FOR /F "tokens=* USEBACKQ" %%F IN (`MODE CON`)DO (
	
	SET /A "_line+=1"
	IF !_line! EQU 4 (
	
		SET "_rawcolumn=%%F"
		SET /A "_column=!_rawcolumn:~16!"
	)
)

:LISTING
REM Rearranging Colors
REM Usage COLOR bg_color+fg_color
COLOR 1f

REM Listing the Notes
ECHO The notes are listed below:
ECHO:

SET /A "_notenumber=0"
SET /A "_index=-1"
FOR /F "tokens=* USEBACKQ" %%Q IN (`DIR ^| FINDSTR /C:".xm"`)DO (	

	SET /A "_notenumber+=1"
	SET /A "_index=_notenumber"
	SET "_list=%%Q"
	SET "_list=!_list:~36!"
	ECHO [!_notenumber!] !_list!
)

REM Skipping no notes
IF !_index! EQU !_notenumber! (GOTO:THE_QUESTION)

REM If no notes found
CLS
CHOICE /T 15 /C YN /D N /N /M "No notes found would you like to make a new one? (y/n)"

IF !ERRORLEVEL! EQU 1 (

	ECHO Please enter the file name:
	SET /P "_file_name="
	ECHO >> !_file_name!.xm
	
	CLS
	ECHO Please enter your notes.
	ECHO:
	ECHO You can use #slash command for
	ECHO //////...
	ECHO:
	ECHO #line command for
	ECHO ______...
	ECHO:
	ECHO and #newline command for new line
	ECHO:
	ECHO Note: Commands must be aligned to the left side!
	ECHO:
	NOTEPAD !_file_name!.xm
	PAUSE
) ELSE (EXIT)

:THE_QUESTION
REM Ask the user to read, write or change a note
CHOICE /C RWCE /N /M "Do you want to read(R), write(W) or change(C) a note? E:EXIT (R/W/C/E)"
ECHO:
IF !ERRORLEVEL! EQU 4 (EXIT)
IF !ERRORLEVEL! EQU 2 (GOTO:SUB_2) ELSE (
	
	SET "_theanswer=SUB_!ERRORLEVEL!"
)

:CURRENTFILE
REM Taking the current file
ECHO Please enter the note number:
SET /P "_line="
SET /A "_index=0"
FOR /F "tokens=* USEBACKQ" %%T IN (`DIR ^| FINDSTR /C:".xm"`)DO (	

	SET /A "_index+=1"
	IF !_index! EQU !_line! (
		
		SET "_text=%%T"
		SET "_current_file=!_text:~36!"
	)
)

REM Number check
SET "_num_check=!_current_file:~0!"
IF !_num_check! EQU ~0 (

	ECHO Wrong number
	GOTO:CURRENTFILE
)

REM Teleporting to the target destination
GOTO:!_theanswer!

:SUB_1
REM Writing file contents to the screen
REM Intermilan -> :~0,5 = Inter, :~5 = milan, :~0,-5 = milan
CLS
FOR /F "delims=↨" %%G IN (!_current_file!) DO (
	
	SET "_text=%%G"
	
	REM Slash function 
	SET "_command=!_text:~0,6!"

	IF !_command! == #slash (
		
		FOR /L %%C IN (1, 1, !_column!) DO (
		
			<nul (SET /P "_any_variable= /")
		)

		SET "_text=#!_text:~6!"
	)
	
	REM Line function
	SET "_command=!_text:~0,5!"

	IF !_command! == #line (

		FOR /L %%C IN (1, 1, !_column!) DO (
		
			<nul (SET /P "_any_variable= _")
		)

		SET "_text=#!_text:~5!"
	)
	
	REM New line function
	SET "_command=!_text:~0,5!"
	IF !_command! == #newline (
		
		SET "_text=#!_text:~5!"
		ECHO:
	)
	
	REM Writing file contents
	IF !_text! NEQ # (ECHO !_text!)
)

PAUSE
CLS
GOTO:LISTING

:SUB_2
ECHO Please enter a note name:
SET /P "_newnote="

REM Name check
SET "_namecheck=!_newnote:~0!"
IF !_namecheck! EQU ~0 (
	
	ECHO Wrong name
	GOTO:SUB_2
)

CLS
COLOR 2f

ECHO You can use #slash command for
ECHO //////...
ECHO:
ECHO #line command for
ECHO ______...
ECHO:
ECHO and #newline command for new line
ECHO:
ECHO Note: Commands are CASE SENSITIVE and must be aligned to the left side.
ECHO:

ECHO You can use #slash command for >> !_newnote!.xm
ECHO //////... >> !_newnote!.xm
ECHO: >> !_newnote!.xm
ECHO #line command for >> !_newnote!.xm
ECHO ______... >> !_newnote!.xm
ECHO: >> !_newnote!.xm
ECHO and #newline command for new line >> !_newnote!.xm
ECHO: >> !_newnote!.xm
ECHO Note: Commands are CASE SENSITIVE and must be aligned to the left side. >> !_newnote!.xm
ECHO: >> !_newnote!.xm

NOTEPAD !_newnote!.xm
PAUSE
CLS
GOTO:LISTING

:SUB_3
CLS
COLOR 2f

ECHO You can use #slash command for
ECHO //////...
ECHO:
ECHO #line command for
ECHO ______...
ECHO:
ECHO and #newline command for new line
ECHO:
ECHO Note: Commands are CASE SENSITIVE and must be aligned to the left side.
ECHO:

NOTEPAD !_current_file!
PAUSE
CLS
GOTO:LISTING
