set /p message=commit_message:
git add *
git commit -m %message%
git push 