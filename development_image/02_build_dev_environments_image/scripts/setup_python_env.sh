#!/bin/bash
# Set up Python development environment

# Ensure we're in the Python workspace
cd /home/developer/dev/python

# Create initial requirements.txt with common development packages
cat > requirements.txt << EOL
pytest>=7.3.1
black>=23.3.0
flake8>=6.0.0
mypy>=1.3.0
python-dotenv>=1.0.0
requests>=2.31.0
EOL

# Set up Python virtual environment
python3.11 -m venv venv
source venv/bin/activate

# Update pip and install base packages
pip install --upgrade pip
pip install -r requirements.txt

# Create a basic pytest configuration
cat > pytest.ini << EOL
[pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test
python_functions = test_*
EOL

# Create initial project structure
mkdir -p {src,tests,docs}

# Create example test file
mkdir -p tests
cat > tests/test_example.py << EOL
def test_example():
    assert True
EOL

# Set correct ownership
chown -R developer:developer /home/developer/dev/python