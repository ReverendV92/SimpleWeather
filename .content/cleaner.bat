@echo off
cls
echo Checking the directory....
:CLEAN
echo Cleaning all crap files...
del /F /S *.cache
del /F /S *.ztmp
del /F /S *.xbox.vtx
del /F /S *.sw.vtx
del /F /S *.log
del /F /S *.DS_Store
del /F /S *__MACOSX
del /F /S *.mdmp
del /F /S *.prt
del /F /S *.lin
del /F /S *.json
echo ------------------------------------------------------
echo Removed all crap files!
goto EXIT

:EXIT
exit