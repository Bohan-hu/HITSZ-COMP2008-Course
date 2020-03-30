set /p message=commit_message:
mkdocs build
cd site
git add *
git commit -m message
git push 
cd ..
git add *
git commit -m message
git push