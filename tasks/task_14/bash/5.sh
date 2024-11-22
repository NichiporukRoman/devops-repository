echo "Commit 1" > file1.txt
git add .
git commit -m "Commit 1"

echo "Commit 2" > file2.txt
rm file1.txt
git add .
git commit -m "Commit 2"

echo "Commit 3" > file3.txt
rm file2.txt
git add .
git commit -m "Commit 3"

echo "Commit 4" > file4.txt
rm file3.txt
git add .
git commit -m "Commit 4"

echo "Commit 5" > file5.txt
rm file4.txt
git add .
git commit -m "Commit 5"
rm file5.txt
