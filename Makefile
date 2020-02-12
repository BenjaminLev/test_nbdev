SRC = $(wildcard notebooks/*.ipynb)

all: nbdev_template_test docs

nbdev_template_test: $(SRC)
	nbdev_build_lib
	touch nbdev_template_test

docs_serve: docs
	cd docs && bundle exec jekyll serve

docs: $(SRC)
	nbdev_build_docs
	touch docs

test:
	nbdev_test_nbs

release: pypi
	nbdev_bump_version

pypi: dist
	twine upload --repository pypi dist/*

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rm -rf dist