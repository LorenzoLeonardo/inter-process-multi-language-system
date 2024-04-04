@echo off

start /B /min "" "remote-call.exe"
start /B /min "" "emailer-service.exe"
start /B /min "" "modern-auth-service.exe"
start "" "smtp-xoauth2.exe"
