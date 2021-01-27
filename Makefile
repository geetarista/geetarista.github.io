build:
	@bundle exec jekyll build

serve:
	@bundle exec jekyll serve \
		--drafts \
		--future \
		--trace \
		--verbose \
		--watch

version:
	@echo `ruby --version`
	@echo `bundle exec jekyll --version`

.PHONY: serve, version
