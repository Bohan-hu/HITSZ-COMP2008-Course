set /p message=commit_message:
git add *
git commit -m %message%
git push 
mkdocs build
cd site
git add *
git commit -m %message%
git push
cd ../handouts
git add *
git commit -m %message%
git push