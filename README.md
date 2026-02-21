#### **Issue: GitHub Push Failed Due to Large Terraform Provider File**


**What Happened?**
---



While pushing code to GitHub, the following error occurred:



remote: error: File Terraform/ec2/.terraform/providers/registry.terraform.io/hashicorp/aws/6.33.0/windows\_amd64/terraform-provider-aws\_v6.33.0\_x5.exe is 806.49 MB

remote: error: this exceeds GitHub's file size limit of 100.00 MB

remote: error: GH001: Large files detected.


##### **Root Cause:**



When running: terraform init



Terraform automatically downloads required provider plugins.In this case, it downloaded the AWS provider:



HashiCorp Terraform AWS Provider



The provider binary was stored inside:



.terraform/providers/



**This file:**



terraform-provider-aws\_v6.33.0\_x5.exe was 806 MB, which exceeds, GitHub file size limit of 100 MB per file Since the .terraform/ folder was not added to .gitignore, Git tracked and attempted to push this large binary file to GitHub.



GitHub rejected the push for exceeding the size limit.


**Why This Should Not Be Committed**
---



The .terraform/ directory:



* Is automatically generated
* Contains OS-specific binaries
* Is very large
* Can be recreated anytime using terraform init
* Is not required in version control



Best practice in DevOps is to never commit generated or binary files.


**Resolution Steps:**

---

**Step 1:** Add Terraform Files to .gitignore



Add the following to .gitignore:



.terraform/

\*.tfstate

\*.tfstate.\*



This prevents Git from tracking Terraform-generated files.



**Step 2:** Remove .terraform From Git Tracking



If already committed:



git rm -r --cached .terraform

git add .gitignore

git commit -m "Removed .terraform folder and updated gitignore"


**Step 3:** (If Push Still Fails): Remove File From Git History



If the large file was already committed, clean the repository:



rm -rf .git

git init

git add .

git commit -m "Clean initial commit"

git branch -M Main

git remote add origin <repo-url>

git push -u origin Main --force

