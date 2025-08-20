---
mode: 'agent'
description: 'Complete Demo: Add Cart Page and Icon with Vision and Agent Mode'
tools: ['changes', 'codebase', 'editFiles', 'fetch', 'findTestFiles', 'githubRepo', 'openSimpleBrowser', 'problems', 'runCommands', 'runTasks', 'search', 'terminalLastCommand', 'testFailure', 'usages', 'playwright', 'github']
---

# Demo: Cart Page and Icon Implementation

## Context
This is a demo for GitHub Copilot Agent Mode and Vision capabilities. You are working with the OctoCAT Supply Chain Management System - a modern TypeScript web application with separate API and Frontend (React) projects.

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

## Design Reference
Use the provided cart design image (../docs/design/cart.png) as the visual reference for implementation. The design shows:
- A clean, modern cart interface
- Item list with product images and names
- Quantity controls (+/- buttons)
- Remove item functionality
- Subtotal and total calculations
- Consistent styling with the existing application

## Technical Requirements

### Frontend Architecture and Building
- Refer to the existing Architecture Doc (../docs/architecture.md) for frontend structure
- Refere to the Building Doc (../docs/building.md) for build instructions

### Implementation Specifications
1. **Cart Context**: Create a CartContext to manage cart state globally
2. **Cart Icon**: Add to Navigation component with item count badge
3. **Cart Page**: Full-featured cart page matching the design
4. **Cart Hook**: Custom hook for cart operations
5. **Integration**: Connect with existing Product pages

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

Begin implementation by analyzing the current codebase structure and then proceed with the cart functionality development.