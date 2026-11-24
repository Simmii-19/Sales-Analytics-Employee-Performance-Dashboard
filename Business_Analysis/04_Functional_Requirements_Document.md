# Functional Requirements Document (FRD)
## Sales Analytics & Employee Performance Dashboard

**Document Type:** Functional Requirements Document  
**Project:** Sales Analytics & Employee Performance Dashboard  
**Version:** 1.0  
**Status:** Proposed – Portfolio Case Study  
**Prepared By:** Business Analyst (Simulated Project Role)

---

## 1. Introduction

This document describes the proposed functional requirements of the Sales Analytics & Employee Performance Dashboard.

The purpose is to explain how the dashboard should work, what features it should provide, and how users should interact with the reports.

The functional requirements are based on the proposed business requirements documented in the BRD.

## 2. System Overview

The proposed solution is an interactive Power BI dashboard developed using the AdventureWorks dataset.

It will provide three analytical pages:

1. Executive Overview
2. Product Performance
3. Sales Trends & Employee Performance

Users will be able to explore historical sales data, review KPIs, apply filters, and analyze business performance.

## 3. User Roles

| User Role | Expected System Usage |
|---|---|
| Senior Management | Review executive KPIs |
| Sales Manager | Analyze revenue and sales trends |
| Regional Manager | Compare regional performance |
| Product Manager | Analyze product performance |
| Business Analyst | Validate business requirements and results |

These roles are simulated for the portfolio project.

## 4. Functional Requirements

### FR-01: Executive KPI Display

**Description:** The dashboard must display important sales performance indicators.

**Expected functionality:**
- Display Total Revenue.
- Display Total Orders.
- Display Units Sold.
- Display Gross Profit where the relevant data supports the calculation.
- Display other defined KPIs where available.

**Expected result:** Users can quickly understand overall sales performance.

### FR-02: Sales Trend Analysis

**Description:** The dashboard must allow users to analyze sales performance over time.

**Expected functionality:**
- Display sales trends by date or year.
- Allow users to identify increases and decreases in sales.
- Present historical sales comparisons where supported by the data.

**Expected result:** Users can understand how sales performance changes over time.

### FR-03: Product Performance Analysis

**Description:** The dashboard must provide product-level sales analysis.

**Expected functionality:**
- Display sales by product.
- Display sales by product category.
- Identify top-performing products.
- Support comparisons of product performance.

**Expected result:** Product stakeholders can understand which products contribute most to sales.

### FR-04: Regional Sales Analysis

**Description:** The dashboard should support analysis of sales performance across available geographical regions.

**Expected functionality:**
- Display sales by available region or territory.
- Allow comparison between regions.
- Highlight differences in regional sales performance.

**Expected result:** Regional stakeholders can identify stronger and weaker sales areas.

### FR-05: Employee Performance Analysis

**Description:** The dashboard must provide visibility into employee-related reseller sales performance.

**Expected functionality:**
- Display reseller sales by employee where supported by the data.
- Allow users to compare employee-related sales results.
- Present relevant sales and profitability indicators.

**Expected result:** Sales management can evaluate employee-related sales performance using the available reseller sales data.

### FR-06: Interactive Filters

**Description:** Users must be able to filter dashboard information using relevant business dimensions.

**Expected functionality:**
- Provide relevant date filters.
- Provide product or category filters where applicable.
- Provide regional filters where applicable.
- Update relevant visuals and KPIs when filters are applied.

**Expected result:** Users can focus on specific parts of the business data.

### FR-07: Visual Reporting

**Description:** The dashboard must present analytical information through understandable visualizations.

**Expected functionality:**
- Display KPI cards.
- Display charts and comparison visuals.
- Use clear labels and titles.
- Maintain consistent formatting across dashboard pages.

**Expected result:** Users can interpret business information without needing to inspect raw database records.

### FR-08: Data and KPI Validation

**Description:** Reported values must be checked against the underlying data and agreed KPI definitions.

**Expected functionality:**
- Validate important KPI calculations.
- Check relevant SQL results against dashboard values.
- Review data relationships and filtering behaviour.
- Investigate differences before reporting results.

**Expected result:** Dashboard results are more reliable and consistent.

## 5. Non-Functional Considerations

The following are proposed quality expectations rather than verified performance results.

| ID | Requirement | Expected Behaviour |
|---|---|---|
| NFR-01 | Usability | Dashboard should be easy to understand and navigate. |
| NFR-02 | Accuracy | KPI calculations should be validated. |
| NFR-03 | Performance | Reports should respond within a reasonable time. |
| NFR-04 | Consistency | KPI definitions and formatting should remain consistent. |
| NFR-05 | Readability | Charts, labels and values should be clearly presented. |

## 6. User Interaction Workflow

1. User opens the Power BI dashboard.
2. User selects the relevant dashboard page.
3. User reviews KPI cards and visualizations.
4. User applies available filters.
5. Dashboard visuals update according to the selected filters.
6. User compares results and identifies business trends.
7. User uses the information to support business decisions.

## 7. Functional Requirement Traceability

| BRD Requirement | Related FRD Requirement |
|---|---|
| BR-01 | FR-01 |
| BR-02 | FR-02 |
| BR-03 | FR-03 |
| BR-04 | FR-04 |
| BR-05 | FR-05 |
| BR-06 | FR-06 |
| BR-07 | FR-07 |
| BR-08 | FR-08 |

## 8. Acceptance Criteria

| Requirement | Acceptance Criteria |
|---|---|
| FR-01 | Relevant KPI cards display validated values. |
| FR-02 | Users can view sales trends across available time periods. |
| FR-03 | Users can identify products with higher and lower sales. |
| FR-04 | Users can compare available regions or territories. |
| FR-05 | Employee-related reseller sales information is available. |
| FR-06 | Applying a filter updates the relevant visuals correctly. |
| FR-07 | Visuals have understandable labels and titles. |
| FR-08 | Important dashboard calculations are checked against SQL results. |

## 9. Assumptions and Limitations

- The dashboard uses historical AdventureWorks data.
- Actual system behaviour depends on the available dataset and implemented Power BI features.
- Internet Sales and Reseller Sales are treated separately where their calculation logic differs.
- Employee-related analysis is limited to the available reseller sales data.
- Proposed features must be checked against the actual dashboard before being marked as implemented.

## 10. Validation Status

This FRD is a proposed functional specification for a portfolio case study.

Actual implementation and testing must be verified against the Power BI dashboard. No formal stakeholder sign-off or production-system testing has been conducted.

## 11. Conclusion

This document translates the business needs in the BRD into functional requirements for the proposed Sales Analytics & Employee Performance Dashboard.

It provides a foundation for implementation, testing, and requirement validation.
