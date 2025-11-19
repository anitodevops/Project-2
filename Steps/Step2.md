# Step 2: Setup Git Repository 

### Create a new git repository – Project-2

### Go to Home page -> click on Repositories -> click New -> enter repository name, description, choose desired visibility (Public/Private) -> click create

### Generate an Access Token

- Go to Settings → Developer settings → Personal Access Tokens → Token(classic)
- Verify & generate new token  
  - Enter token name 
  - select permissions
    - Repository → Contents → Read and Write
    - Repository → Metadata → Read-only
    - Webhooks → Read and Write
    - Administration → Read and Write
  - click generate.

#### Clone the Source code repository

  `git clone https://github.com/anithaambrose/Trendstore.git`

#### Initialize git repo
```
cd Trendstore
git init
```

*Note:
Ensure the cloned repo with  /build or /dist folder contains static files and index.html.*
