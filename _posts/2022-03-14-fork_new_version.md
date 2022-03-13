---
layout: post
title: fork repository 최신 버전으로 업데이트 하는 방법
subtitle: fetch upstream를 직접하는 방법
categories: github
tags: [github, problem]
---

## 문제발생

옛날에 fork했던 repository에서 버전이 업데이트 됐다는 것을 확인했다.

![image](https://user-images.githubusercontent.com/68064510/158068826-1a73d8df-67c5-49d0-9a47-58494b4f22fc.png)  

곧바로 Fetch upstream을 클릭했다.  

</br>

<center><img src="https://user-images.githubusercontent.com/68064510/158068919-2a71ff3a-53dd-4ce9-9ed3-25bd0136538c.png" width="50%" height="50%"></center>  

</br>

Can’t automatically merge. Don’t worry, you can still create the pull request 문제가 발생했다.

![image](https://user-images.githubusercontent.com/68064510/158069178-180a43e7-3023-40bb-860b-6cdcd47fa326.png)

</br>

## 해결 방안

터미널 창에서 직접 Fetch upstream을 하자!  
(vscode 터미널 창에서 작성했다)

</br>

```bash
# 원격저장소 확인
git remote -v

# 원격저장소 바꾸기 위해 기존 원격저장소 제거
git remote remove upstream

# 원격저장소 추가
remote add upstream https://github.com/사용자/레퍼지토리.git  

# fetch
git fetch upstream
```

</br>

이제 내 브랜치로 merge 해준다.  

</br>

```bash
# 지금 위치의 branch로 merge
git merge upstream/master
```
그 뒤로는 혹시나 몰라서 원격저장소 추가해준 걸 제거하고 (안해도 상관없다)  
git add와 git commit 등 원래대로 해주면 된다.
