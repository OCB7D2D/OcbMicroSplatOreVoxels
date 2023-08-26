@echo off

webmerge -f "%~dp0\.optimize.conf.xml" --optimize --jobs 64 -l 6 %*

pause