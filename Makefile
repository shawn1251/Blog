# Makefile to trigger shell scripts for creating a new post and deploying

# Define the shell scripts
CREATE_POST_SCRIPT := create-post.sh
DEPLOY_SCRIPT := deploy.sh

# Target to create a new post
.PHONY: create-post
create-post:
	@./$(CREATE_POST_SCRIPT)

# Target to deploy the project
.PHONY: deploy
deploy:
	@./$(DEPLOY_SCRIPT)

# Target to run the project locally
.PHONY: run
run:
	@hugo server -D