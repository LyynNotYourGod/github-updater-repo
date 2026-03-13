# github-update#!/data/data/com.termux/files/usr/bin/bash

read -p "GitHub Username: " username
read -p "Repository Name: " repo
read -p "Branch (default: main): " branch
branch=${branch:-main}
read -p "GitHub Token: " token

echo "[*] Inisialisasi Git repo…"
git init

git config --global user.name "$username"
git config --global user.email "$username@users.noreply.github.com"
git config --global --add safe.directory "$(pwd)"

echo "[*] Menambahkan semua file…"
git add .

git commit -m "Upload: $(date)"

git branch -M $branch

git remote add origin https://$username:$token@github.com/$username/$repo.git

echo "[*] Fetch dari remote…"
git fetch origin $branch

echo "[*] Cek apakah remote punya history…"
if git rev-parse --verify origin/$branch >/dev/null 2>&1; then
   echo "[*] Remote ada commit, rebase dulu…"
   git rebase origin/$branch
fi

echo "[*] Push ke GitHub…"
git push -u origin $branch

echo "[v] Upload selesai ke $repo di cabang $branch!"
r-repo
