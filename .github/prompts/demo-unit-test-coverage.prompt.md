---
mode: 'agent'
description: 'Demo: Improve API Test Coverage - Add Unit Tests for Missing Routes.'
tools: ['changes', 'codebase', 'editFiles', 'fetch', 'findTestFiles', 'githubRepo', 'problems', 'runCommands', 'runTasks', 'search', 'terminalLastCommand', 'testFailure', 'usages', 'playwright', 'github', 'Azure MCP Server']
---
# 🧪 Improve API Test Coverage - Add Unit Tests for Missing Controllers and Services

## 📊 Current State
Add tests for the Product and Supplier controllers and services.

## 🎯 Objective
Increase API test coverage by implementing comprehensive unit tests for Spring Boot Product and Supplier controllers and services.

## 📋 Missing Test Files

### 🎮 Controller Tests (High Priority)
The following REST controllers need unit tests:

- [ ] `src/test/java/com/github/av2/api/controller/ProductControllerTest.java`
- [ ] `src/test/java/com/github/av2/api/controller/SupplierControllerTest.java`

### 🔧 Service Tests (High Priority)
The following business logic services need unit tests:

- [ ] `src/test/java/com/github/av2/api/service/ProductServiceTest.java`
- [ ] `src/test/java/com/github/av2/api/service/SupplierServiceTest.java`

## ✅ Test Coverage Requirements

### For Each Controller Test:
- **REST Endpoint Testing:**
  - ✅ GET all entities (`/api/{entities}`)
  - ✅ GET single entity by ID (`/api/{entities}/{id}`)
  - ✅ POST create new entity (`/api/{entities}`)
  - ✅ PUT update existing entity (`/api/{entities}/{id}`)
  - ✅ DELETE entity by ID (`/api/{entities}/{id}`)

- **HTTP Status Code Validation:**
  - ❌ 404 for non-existent entities
  - ❌ 400 for invalid request payloads
  - ❌ 422 for validation errors
  - ❌ Edge cases (malformed IDs, empty requests)

### For Each Service Test:
- **Business Logic Testing:**
  - ✅ CRUD operations (findAll, findById, save, deleteById)
  - ✅ Data validation and transformation
  - ✅ Exception handling
  - ✅ Edge cases and boundary conditions

## 🛠️ Implementation Guidelines

### Use Existing Patterns
Follow the patterns established in existing test files:

**Controller Tests** - Use `BranchControllerTest.java`:
```java
@WebMvcTest(EntityController.class)
class EntityControllerTest {
    @Autowired
    private MockMvc mockMvc;
    
    @MockBean
    private EntityService entityService;
    
    @Autowired
    private ObjectMapper objectMapper;
}
```

**Service Tests** - Use `BranchServiceTest.java`:
```java
class EntityServiceTest {
    @Mock
    private SeedData seedData;
    
    private EntityService entityService;
    
    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        entityService = new EntityService(seedData);
    }
}
```

### Test Structure Template

**Controller Test Structure:**
```java
@Test
void getAllEntities_ShouldReturnList() throws Exception {
    // Arrange
    when(entityService.findAll()).thenReturn(Arrays.asList(testEntity));
    
    // Act & Assert
    mockMvc.perform(get("/api/entities"))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$[0].id").value(testEntity.getId()));
}
```

**Service Test Structure:**
```java
@Test
void findAll_ShouldReturnAllEntities() {
    // Arrange
    when(seedData.getEntities()).thenReturn(Arrays.asList(testEntity));
    
    // Act
    List<Entity> result = entityService.findAll();
    
    // Assert
    assertNotNull(result);
    assertEquals(1, result.size());
}
```

## 🎯 Coverage Targets

### Phase 1: Product and Supplier Controllers (Immediate)
- **Target: 80%+ controller coverage**
- Focus on happy path REST endpoints
- Use `BranchControllerTest.java` as template

### Phase 2: SProduct and Supplier ervices (Short-term)
- **Target: 85%+ service coverage**
- Focus on business logic validation
- Use `BranchServiceTest.java` as template

### Phase 3: Product and Supplier Error Handling (Follow-up)
- **Target: 90%+ overall coverage**
- Add comprehensive error scenarios
- Add edge case validation

## 🔧 Running Tests

```bash
# Run all tests
cd api && mvn test

# Run tests with coverage report
cd api && mvn test jacoco:report

# Run specific test class
cd api && mvn test -Dtest=ProductControllerTest

# Run specific test method
cd api && mvn test -Dtest=ProductControllerTest#getAllProducts_ShouldReturnList
```

## 📈 Success Criteria
- [ ] Product and Supplier controller test files created
- [ ] Product and Supplier service test files created
- [ ] All tests passing in CI/CD

## 🚀 Getting Started
1. Start with `ProductControllerTest.java` - copy `BranchControllerTest.java` pattern
2. Create corresponding `ProductServiceTest.java` - copy `BranchServiceTest.java` pattern
3. Implement basic CRUD tests first
4. Add error scenarios incrementally
5. Run coverage after each file to track progress
6. Follow ERD relationships for cross-entity testing

## 📚 Related Files
- ERD Diagram: `api/ERD.png`
- Existing controller test: `api/src/test/java/com/github/av2/api/controller/BranchControllerTest.java`
- Existing service test: `api/src/test/java/com/github/av2/api/service/BranchServiceTest.java`
- Maven configuration: `api/pom.xml`
- Coverage report: `api/target/site/jacoco/index.html`