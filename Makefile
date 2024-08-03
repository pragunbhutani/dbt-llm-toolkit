# dbt-llm-tools Makefile
# ~~~~~~~~~~~~~~~~~
#
# Shortcuts for various tasks.

documentation:
	@(poetry export --with docs -f requirements.txt -o requirements-docs.txt; cd docs; make html)

test:
	poetry run pytest tests

doctest:
	@(cd docs/source; sphinx-build -b doctest . _build/doctest)

make poetry:
	@(curl -sSL https://install.python-poetry.org | python3 -)

make lint:
	@(poetry run pylint dbt_llm_tools tests client; poetry run flake8 dbt_llm_tools tests client)

# install poetry and dependencies
install:
	@(poetry install; pre-commit install; mkdir -p .local_storage)

# Fetch the open source project from GitLab as an example to play with.
fetch_example_project:
	@( \
		git clone https://github.com/stacktonic-com/stacktonic-dbt-example-project.git example_dbt_project; \
		echo "Example project fetched to ./example_dbt_project/" \
	)

# Run the streamlit client
run_client:
	@(mkdir -p .local_storage; poetry run streamlit run client/app.py)

# Clean the local storage
clean_local_storage:
	@(rm -rf .local_storage)