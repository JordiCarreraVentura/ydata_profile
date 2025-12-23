VENV_NAME := main
VENV_DIR  := test_env/$(VENV_NAME)
VENV_PY   := $(VENV_DIR)/bin/python
PIP	   := $(VENV_DIR)/bin/pip
PYTHON	:= python3.11

makenv:
	@if [ ! -d "$(VENV_DIR)" ]; then \
		echo "Creating virtual environment: $(VENV_NAME)"; \
		virtualenv -p "$(PYTHON)" "$(VENV_DIR)"; \
	fi

install: makenv
	$(PIP) install -r requirements.txt
	$(PIP) install -r requirements_test.txt

test-integration: makenv
	$(VENV_PY) tests/test_integration.py

test: install test-integration

app:
	@$(VENV_PY) -m streamlit run src/ydata_profile/streamlit_app.py

all: makenv install
	@echo "Nothing else to do yet."
