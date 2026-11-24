# Test Cases and User Acceptance Testing (UAT)
## Sales Analytics & Employee Performance Dashboard

**Document Type:** Test Cases and UAT  
**Project:** Sales Analytics & Employee Performance Dashboard  
**Version:** 1.0  
**Status:** Proposed – Portfolio Case Study  
**Prepared By:** Business Analyst (Simulated Project Role)

---

## 1. Introduction

This document defines proposed test cases and User Acceptance Testing (UAT) scenarios for the Sales Analytics & Employee Performance Dashboard.

The objective is to verify that dashboard features work as expected and that the solution meets the documented business requirements.

## 2. Testing Objectives

- Verify KPI calculations.
- Validate dashboard filters.
- Check product and regional analysis.
- Verify sales trend visualizations.
- Identify and document defects.
- Confirm that dashboard functionality supports business needs.

## 3. Test Case Scenarios

### TC-01: Verify Total Revenue KPI

**Requirement:** FR-01

**Test Steps:**
1. Open the Executive Overview page.
2. Locate the Total Revenue KPI.
3. Compare its value against the corresponding SQL calculation.

**Expected Result:** The dashboard displays the correct revenue value for the selected filters.

### TC-02: Verify Date Filter

**Requirement:** FR-06

**Test Steps:**
1. Open the dashboard.
2. Select the year 2013.
3. Observe the revenue KPI and relevant charts.

**Expected Result:** Relevant dashboard visuals update according to the selected date filter.

### TC-03: Verify Product Revenue Ranking

**Requirement:** FR-03

**Test Steps:**
1. Open the Product Performance page.
2. Review product-wise revenue.
3. Identify the five products with the highest revenue.
4. Compare the ranking with the corresponding SQL result.

**Expected Result:** Products are correctly ranked by revenue.

### TC-04: Verify Regional Sales Analysis

**Requirement:** FR-04

**Test Steps:**
1. Open the relevant sales analysis page.
2. Review available regional or territory-wise sales.
3. Compare the displayed values against SQL results.

**Expected Result:** Regional sales information is displayed accurately.

### TC-05: Verify Employee-Related Sales

**Requirement:** FR-05

**Test Steps:**
1. Open the Sales Trends & Employee Performance page.
2. Review employee-related reseller sales.
3. Compare selected values against the corresponding SQL calculation.

**Expected Result:** Employee-related reseller sales results are displayed correctly.

### TC-06: Verify Dashboard Navigation

**Requirement:** FR-07

**Test Steps:**
1. Open the dashboard.
2. Navigate between all three dashboard pages.
3. Review page titles and visualizations.

**Expected Result:** Users can navigate between dashboard pages and understand the information presented.

## 4. Test Execution Tracking

| Test Case ID | Test Scenario | Execution Status | Remarks |
|---|---|---|---|
| TC-01 | Revenue KPI validation | Not Executed | Pending validation |
| TC-02 | Date filter validation | Not Executed | Pending validation |
| TC-03 | Product ranking validation | Not Executed | Pending validation |
| TC-04 | Regional analysis validation | Not Executed | Pending validation |
| TC-05 | Employee sales validation | Not Executed | Pending validation |
| TC-06 | Dashboard navigation | Not Executed | Pending validation |

**Note:** These are proposed test cases. Update the execution status only after actually performing each test.

## 5. Defect Reporting Process

When actual behaviour differs from expected behaviour:

1. Reproduce the issue.
2. Record the steps to reproduce it.
3. Document the expected result.
4. Document the actual result.
5. Assess business impact and priority.
6. Communicate the defect to the technical team.
7. Retest after the fix.
8. Update the defect status.

### Sample Defect Report

**Defect
