PUBLIC_DIR=public
DEPLOY_DIR=../public

DISTR_PARAMS=--environment distribution

default: usage

generate: ## Generate site
	@hugo -D

server: ## Start Hugo server for realtime updates
	@hugo server -D

deploy:
	@hugo $(DISTR_PARAMS)
	@find $(DEPLOY_DIR) -mindepth 1 -maxdepth 1 -not -name .git -print0 | xargs -0 rm -fr --
	@cp -R $(PUBLIC_DIR)/ $(DEPLOY_DIR)/
	@cd $(DEPLOY_DIR)/ && git add . && git commit -a -m "auto-generated" && git push

usage: ## List available targets
	@echo
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo
