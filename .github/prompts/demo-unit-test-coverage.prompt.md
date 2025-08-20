---
mode: 'agent'
description: 'Demo: Improve API Test Coverage - Add Unit Tests for Missing Routes.'
tools: ['changes', 'codebase', 'editFiles', 'fetch', 'findTestFiles', 'githubRepo', 'problems', 'runCommands', 'runTasks', 'search', 'terminalLastCommand', 'testFailure', 'usages', 'playwright', 'github', 'Azure MCP Server']
---
# 🧪 Python API Unit Test Coverage Scenario: Product & Supplier Routes

## 📊 Current State
- **Limited test coverage** for FastAPI routes and Pydantic models
- **Product and Supplier routes/models lack dedicated tests**
- Only `test_branch.py` exists as a reference

## 🎯 Objective
Increase Python API test coverage for Product and Supplier routes and models to **85%+** by implementing comprehensive unit tests.

## 📋 Missing Test Files

#### 🔗 Route Tests (High Priority)
- [ ] `tests/test_product.py` (for `app/routes/product.py`)
- [ ] `tests/test_supplier.py` (for `app/routes/supplier.py`)

#### 🏗️ Model Tests (Medium Priority)
- [ ] `tests/test_models_product.py` (for `app/models/product.py`)
- [ ] `tests/test_models_supplier.py` (for `app/models/supplier.py`)

## ✅ Test Coverage Requirements

#### For Each Route Test File:
- **CRUD Operations:**
  - ✅ GET all entities (`/api/products`, `/api/suppliers`)
  - ✅ GET single entity by ID
  - ✅ POST create new entity
  - ✅ PUT update existing entity
  - ✅ DELETE entity by ID
- **FastAPI Error Scenarios:**
  - ❌ 404 for non-existent entities
  - ❌ 400 for invalid request payloads
  - ❌ 422 for Pydantic validation errors
  - ❌ Edge cases (malformed IDs, empty requests)

#### For Each Model Test File:
- Pydantic model validation
- Field types and constraints
- Required vs optional fields
- Default values
- Custom validators
- JSON serialization/deserialization

## 🛠️ Implementation Guidelines

#### Use Existing Pattern
Follow the pattern in `tests/test_branch.py`:
```python
import pytest
from fastapi import status
from app.seed_data import products as seed_products

def test_get_all_products(client):
    response = client.get("/api/products")
    assert response.status_code == status.HTTP_200_OK
```

#### Test Structure Template
```python
import pytest
from fastapi import status

def test_create_entity(client, test_entity):
    response = client.post("/api/entities", json=test_entity)
    assert response.status_code == status.HTTP_201_CREATED

def test_get_all_entities(client):
    response = client.get("/api/entities")
    assert response.status_code == status.HTTP_200_OK

def test_get_entity_by_id(client):
    # Test implementation

def test_update_entity(client, test_entity):
    # Test implementation

def test_delete_entity(client):
    # Test implementation

def test_get_entity_not_found(client):
    response = client.get("/api/entities/99999")
    assert response.status_code == status.HTTP_404_NOT_FOUND
```

#### Model Test Template
```python
import pytest
from pydantic import ValidationError
from app.models.product import Product

def test_product_model_valid():
    product = Product(name="Widget", price=9.99)
    assert product.name == "Widget"

def test_product_model_validation_error():
    with pytest.raises(ValidationError):
        Product(price="not-a-float")
```

## 🎯 Coverage Targets
- **Route coverage:** 90%+
- **Model coverage:** 70%+
- **All tests passing in CI/CD**

## 🔧 Running Tests
```bash
cd api && python -m pytest
cd api && python -m pytest --cov=app --cov-report=html
cd api && python -m pytest tests/test_product.py
```

## 📈 Success Criteria
- [ ] Both route test files created and cover all endpoints
- [ ] Both model test files created and cover all fields/validation
- [ ] Route and model coverage targets met
- [ ] All tests passing

## 🚀 Getting Started
1. Start with `test_product.py` using `test_branch.py` as a template
2. Implement CRUD and error tests for Product, then Supplier
3. Add model validation tests
4. Run coverage after each file
5. Ensure all tests pass

## 📚 Related Files
- Existing test: `api/tests/test_branch.py`
- Product route: `api/app/routes/product.py`
- Supplier route: `api/app/routes/supplier.py`
- Product model: `api/app/models/product.py`
- Supplier model: `api/app/models/supplier.py`
- Pytest fixtures: `api/tests/conftest.py`
- ERD: `api/ERD.png`