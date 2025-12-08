---
mode: 'agent'
description: 'Use Coding Agent to test multiple paths - in parallel!'
tools: ['codebase', 'fetch', 'findTestFiles', 'githubRepo', 'openSimpleBrowser', 'problems', 'search', 'searchResults', 'usages', 'add_sub_issue', 'assign_copilot_to_issue', 'create_issue', 'get_issue', 'list_issues', 'list_sub_issues', 'search_issues', 'update_issue', 'github']
---

# Demo: Use Coding Agent to test multiple paths - in parallel!

## Context
This is a demo for GitHub Copilot Coding Agent. Experimentation can be hard, expensive and take a long time. This demo shows how to use the Coding Agent to test multiple paths in parallel, allowing you to explore different solutions and approaches quickly.

## Current State
- The application has a Products page where users can view items
- Users can click "Add to Cart" but nothing actually happens except showing a message
- There is NO cart functionality implemented yet
- The NavBar does not have a Cart icon

## Demo Goal
Implement a complete Cart system including:
1. A Cart icon in the NavBar that shows the number of items
2. A dedicated Cart page with full functionality
3. Cart state management across the application
4. Free shipping for orders over $100, otherwise $25 shipping fee
5. Add/remove items functionality
6. Remove the alert message when adding items to the cart

## Instructions
1. First analyze the repo and use the instructions/context below to create a high-level plan for the implementation.
2. Create 3 different VISUAL design approaches for the Cart Page and Cart Icon: all of them must use local browser state management, but they can differ in how the Cart Icon is implemented, and how the Cart Page is structured. Do not modify other pages other than the Cart Page and Cart Icon.
3. Summarize the designs in a sentence or two each.
4. Create an Epic issue in the GitHub repository called "Cart Page Experimentation".
5. For each design, create a separate sub-issue in the Epic issue.
6. Assign the Copilot Agent to each sub-issue to implement the design in parallel.

### Frontend Architecture and Building
- Refer to the existing Architecture Doc (../docs/architecture.md) for frontend structure
- Refere to the Building Doc (../docs/building.md) for build instructions

### Implementation Specifications
1. **Cart Context**: Create a CartContext to manage cart state globally
2. **Cart Icon**: Add to Navigation component with item count badge
3. **Cart Hook**: Custom hook for cart operations
4. **Integration**: Connect with existing Product pages

### Key Features to Implement
- Add items to cart from product pages
- View all cart items on dedicated cart page
- Update item quantities
- Remove items from cart
- Calculate subtotals and totals
- Calculate shipping costs based on total price
- Persist cart state (localStorage)
- Responsive design matching existing app style

## Success Criteria
After implementation, users should be able to:
1. See a cart icon in the navigation with item count
2. Add products to cart from the Products page
3. Navigate to cart page by clicking the cart icon
4. View all items in their cart
5. Modify quantities of cart items
6. See shipping costs applied based on total price
7. Remove items from cart
8. See accurate total calculations

## Implementation Instructions
1. Analyze the existing codebase structure
2. Create cart state management (Context + Hook)
3. Add cart icon to Navigation component
4. Create Cart page component
5. Integrate cart functionality with existing Product components
6. Style components to match existing design system
7. Test the complete cart workflow

## Notes
- Follow existing code patterns and styling conventions
- Maintain consistency with current navigation and routing
- Ensure responsive design
- Ensure styling works for both Dark and Light modes
- Handle edge cases (empty cart, etc.)