---
mode: 'agent'
description: 'Demo: Improve API Test Coverage - Add Unit Tests for Missing Routes.'
tools: ['changes', 'codebase', 'editFiles', 'fetch', 'findTestFiles', 'githubRepo', 'problems', 'runCommands', 'runTasks', 'search', 'terminalLastCommand', 'testFailure', 'usages', 'playwright', 'github', 'Azure MCP Server']
---
# 🧪 Demo: Add Unit Tests for Product and Supplier Routes

## 📊 Current State
- Only **1 test file exists**: `branch.test.ts`

## 🎯 Objective
Increase API test coverage by implementing comprehensive unit tests for Product and Supplier routes.

## 📋 Missing Test Files

### 🔗 Route Tests (High Priority)
The following route files need complete test coverage:

- [ ] `src/routes/product.test.ts`
- [ ] `src/routes/supplier.test.ts`

## ✅ Test Coverage Requirements

### For Each Route Test File:
- **CRUD Operations:**
  - ✅ GET all entities
  - ✅ GET single entity by ID
  - ✅ POST create new entity
  - ✅ PUT update existing entity
  - ✅ DELETE entity by ID

- **Error Scenarios:**
  - ❌ 404 for non-existent entities
  - ❌ 400 for invalid request payloads
  - ❌ 422 for validation errors
  - ❌ Edge cases (malformed IDs, empty requests)

## 🛠️ Implementation Guidelines

### Use Existing Pattern
Follow the pattern established in `src/routes/branch.test.ts`:
```typescript
import { describe, it, expect, beforeEach } from 'vitest';
import request from 'supertest';
import express from 'express';
```

### Test Structure Template
```typescript
describe('[Entity] API', () => {
    beforeEach(() => {
        // Setup app and reset data
    });

    it('should create a new [entity]', async () => { /* POST test */ });
    it('should get all [entities]', async () => { /* GET all test */ });
    it('should get a [entity] by ID', async () => { /* GET by ID test */ });
    it('should update a [entity] by ID', async () => { /* PUT test */ });
    it('should delete a [entity] by ID', async () => { /* DELETE test */ });
    it('should return 404 for non-existing [entity]', async () => { /* Error test */ });
});
```

## 🔧 Running Tests

```bash
# Run all tests
npm run test:api

# Run tests with coverage
npm run test:api -- -- --coverage

# Run specific test file
npm run test:api -- src/routes/product.test.ts
```

## 📈 Success Criteria
- [ ] Add route test files for Product and Supplier
- [ ] All tests passing in CI/CD

## 🚀 Getting Started
1. Start with `product.test.ts` - copy `branch.test.ts` pattern
2. Implement basic CRUD tests first
3. Add error scenarios incrementally
4. Run coverage after each file to track progress
5. Follow ERD relationships for cross-entity testing

## 📚 Related Files
- ERD Diagram: `api/ERD.png`
- Existing test: `api/src/routes/branch.test.ts`
- Test config: `api/vitest.config.ts`
- Coverage report: `api/coverage/index.html`