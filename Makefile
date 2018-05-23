build:
	@bundle exec jekyll build

serve:
	@bundle exec jekyll serve \
		--drafts \
		--future \
		--trace \
		--verbose \
		--watch

.PHONY: serve
