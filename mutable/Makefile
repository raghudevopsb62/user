help:
	@echo "Usage: make dev | make prod"

dev dev-apply:
	@cd env-dev && rm -rf .terraform && terraform init && terraform apply -auto-approve

prod prod-apply:
	@cd env-prod && rm -rf .terraform && terraform init && terraform apply -auto-approve

dev-destroy:
	@cd env-dev && rm -rf .terraform && terraform init && terraform destroy -auto-approve

prod-destroy:
	@cd env-prod && rm -rf .terraform && terraform init && terraform destroy -auto-approve

