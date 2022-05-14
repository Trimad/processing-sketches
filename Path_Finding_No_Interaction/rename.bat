@echo off
setlocal EnableDelayedExpansion
set i=0
for %%a in (*.tif) do (
    set /a i+=1
    ren "%%a" "!i!.new"
)
ren *.new *.tif