# Change Request & Scope Management

## 1. Introduction

Scope Management defines what is included and excluded from a project. It helps prevent unnecessary changes and ensures that the project stays aligned with business objectives, budget, timelines, and resources.

This document explains how change requests can be evaluated and managed for the Sales Analytics & Employee Performance Dashboard.

## 2. Project Scope

### In Scope
- Historical sales data analysis.
- Total revenue, total orders, and gross profit calculations.
- Top-performing and low-performing product analysis.
- Regional sales performance analysis.
- Employee and reseller sales performance analysis.
- Interactive Power BI dashboards.
- Business insights and recommendations.

### Out of Scope
- Future sales forecasting.
- Real-time sales monitoring.
- Customer relationship management.
- Automated email notifications.
- External business application integration.

### Scope Diagram

```mermaid
flowchart TD
    A[Sales Analytics Dashboard]
    A --> B[In Scope]
    A --> C[Out of Scope]
    B --> D[Historical Sales Analysis]
    B --> E[Product Performance]
    B --> F[Regional Performance]
    B --> G[Employee Performance]
    B --> H[Power BI Dashboard]
    C --> I[Sales Forecasting]
    C --> J[Real-Time Monitoring]
    C --> K[CRM Integration]
    C --> L[Automated Notifications]
```

## 3. What Is Change Request Management?

Change Request Management is the process of receiving, reviewing, evaluating, approving, and tracking changes requested during a project.

A Business Analyst evaluates whether a proposed change:
- Supports business objectives.
- Affects the existing project scope.
- Requires additional time or resources.
- Creates technical dependencies.
- Should be approved, rejected, or postponed.

## 4. Change Request Management Flowchart

```mermaid
flowchart TD
    A([New Change Request]) --> B[BA Receives Request]
    B --> C[Understand Business Need]
    C --> D[Analyze Impact on Scope, Cost and Timeline]
    D --> E{Is Change Approved?}
    E -->|Yes| F[Update Requirements]
    E -->|No| G[Document Rejection]
    F --> H[Technical Team Implements Change]
    H --> I[Testing and Validation]
    I --> J{Testing Successful?}
    J -->|Yes| K([Close Change Request])
    J -->|No| H
```

## 5. Example Business Scenario

**Scenario:** A Sales Manager requests a monthly sales forecasting feature.

However, the
