# Git Hands-On Exercise 5
## CTS Digital Nurture 5.0

**Student Name:** Saranya  
**Track:** .NET Full Stack Engineer

---

## Objective

This repository contains the implementation of **Git Hands-On Exercise 5 – Git Merge Conflict Resolution** completed as part of the **CTS Digital Nurture 5.0** program.

The objective of this experiment is to:

- Create and work with multiple Git branches.
- Create and resolve merge conflicts.
- Compare changes using Git Diff and P4Merge.
- Configure and use `.gitignore`.
- Delete merged branches.
- Push the final repository to the remote Git repository.

---

## Repository Contents

- `README.md`
- `.gitignore`
- `welcome.txt`
- `hello.xml`

*(Include `branch.txt` and `hello.xml.orig` only if your faculty specifically requires them.)*

---

## Git Commands Used

```bash
git status
git branch
git checkout -b GitWork
git add hello.xml
git commit -m "Added hello.xml in GitWork branch"
git checkout master
git add hello.xml
git commit -m "Added hello.xml in master branch"
git log --oneline --graph --decorate --all
git diff master GitWork
git difftool master GitWork
git merge GitWork
git mergetool
git add hello.xml
git commit -m "Resolved merge conflict"
git status
git add .gitignore
git commit -m "Updated .gitignore to ignore .bak files"
git branch -d GitWork
git push origin master
```

---

## Learning Outcomes

- Created and managed Git branches.
- Compared changes using Git Diff.
- Resolved merge conflicts using Git and P4Merge.
- Ignored unwanted files using `.gitignore`.
- Successfully completed the merge process.
- Pushed the completed project to the remote repository.

---

**CTS Digital Nurture 5.0 – Git Hands-On Exercise**
