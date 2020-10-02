@ECHO OFF

SETLOCAL EnableDelayedExpansion

REM Title
TITLE Cmd_Note

REM Utf-8 (CAUTION MAKES CRASH!)
REM CHCP 65001>nul

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
ECHO:

REM Skipping no notes
IF !_index! EQU !_notenumber! (GOTO:THE_QUESTION)

REM If no notes found
CLS
CHOICE /T 35 /C YN /D N /N /M "No notes found would you like to make a new one? (y/n)"

IF !ERRORLEVEL! EQU 1 (

	ECHO Please enter the file name:
	SET /P "_file_name="
	ECHO: >> !_file_name!.xm
	
	CLS
	ECHO Available commands are:
	ECHO:
	ECHO #slash
	ECHO #line
	ECHO #dots
	ECHO #color [args]
	ECHO #pause
	ECHO #new
	ECHO:
	ECHO Note: Commands are CASE SENSITIVE and must be aligned to the left side.
	
	ECHO Available commands are: >> !_file_name!.xm
	ECHO: >> !_file_name!.xm
	
	ECHO #slash>> !_file_name!.xm
	ECHO #line>> !_file_name!.xm
	ECHO #dots>> !_file_name!.xm
	ECHO #star>> !_file_name!.xm
	ECHO #color>> !_file_name!.xm
	ECHO #pause>> !_file_name!.xm
	ECHO #new>> !_file_name!.xm
	ECHO: >> !_file_name!.xm
	
	ECHO Note: Commands are CASE SENSITIVE and must be aligned to the left side. >> !_file_name!.xm
	ECHO: >> !_file_name!.xm

	NOTEPAD !_file_name!.xm
	PAUSE
	
) ELSE (EXIT)

:THE_QUESTION
REM Ask the user to read, write or change a note
CHOICE /C RWCED /N /M "Read(R), Write(W) Change(C) Delete(D) E:EXIT"
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

:SUB_5
DEL !_current_file!

CLS
GOTO:LISTING

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
		
			<nul (SET /P "_any_variable= -")
		)

		SET "_text=#!_text:~5!"
	)
		
	REM Color function
	SET "_command=!_text:~0,6!"
	IF !_command! == #color (

		SET "_col_val=!_text:~-2!"
		
		COLOR !_col_val!
		
		SET "_text=#!_text:~9!"
	)
	
	REM Pause function
	SET "_command=!_text:~0,6!"
	IF !_command! == #pause (
	
		SET "_text=#!_text:~6!"
		
		ECHO:
		ECHO:
		
		PAUSE
		
		ECHO:
	)
	
	REM Dots function
	SET "_command=!_text:~0,5!"
	IF !_command! == #dots (

		FOR /L %%C IN (1, 1, !_column!) DO (
		
			<nul (SET /P "_any_variable= .")
		)

		SET "_text=#!_text:~5!"
	)
	
	REM Star function
	SET "_command=!_text:~0,5!"
	IF !_command! == #star (

		FOR /L %%C IN (1, 1, !_column!) DO (
		
			<nul (SET /P "_any_variable= *")
		)

		SET "_text=#!_text:~5!"
	)
	
	REM New line function
	SET "_command=!_text:~0,4!"
	IF !_command! == #new (
		
		SET "_text=#!_text:~4!"
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

ECHO Available commands are:
ECHO:
ECHO #slash
ECHO #line
ECHO #dots
ECHO #color [args]
ECHO #pause
ECHO #new
ECHO:
ECHO Note: Commands are CASE SENSITIVE and must be aligned to the left side.

ECHO Available commands are: >> !_newnote!.xm
ECHO: >> !_newnote!.xm

ECHO #slash>> !_newnote!.xm
ECHO #line>> !_newnote!.xm
ECHO #dots>> !_newnote!.xm
ECHO #star>> !_newnote!.xm
ECHO #color>> !_newnote!.xm
ECHO #pause>> !_newnote!.xm
ECHO #new >> !_newnote!.xm
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

ECHO Available commands are:
ECHO:
ECHO #slash
ECHO #line
ECHO #dots
ECHO #star
ECHO #color [args]
ECHO #pause
ECHO #new
ECHO:
ECHO Note: Commands are CASE SENSITIVE and must be aligned to the left side.

NOTEPAD !_current_file!
PAUSE
CLS
GOTO:LISTING
