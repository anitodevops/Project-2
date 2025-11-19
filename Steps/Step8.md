
# Step 8: GitHub Webhook Setup

### Add Webhook 
- Setup webhook to GitHub repo to trigger Jenkins pipeline automatically when code is Pushed to git repository

-	Go to GitHub Repo -> settings -> webhooks -> add Webhook 
    - URL : http://3.109.186.176:8080/github-webhook/
    - Content type: application/json
    - Trigger: “push”

![webhook](https://github.com/anitodevops/Project-2/blob/main/Images/Webhook-Setup.png)

