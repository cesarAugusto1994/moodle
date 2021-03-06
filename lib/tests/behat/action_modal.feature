@core
Feature: Close modals by clicking outside them
  In order to easily close the currently open pop-up
  As a user
  Clicking outside the modal should close it if it doesn't contain a form.

  @javascript
  Scenario: The popup closes when clicked on dead space - YUI
    Given the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |
    And the following "activities" exist:
      | activity | name           | intro                 | course | idnumber |
      | quiz     | Test quiz name | Test quiz description | C1     | quiz1    |
    And I log in as "admin"
    And I am on "Course 1" course homepage
    And I follow "Test quiz name"
    And I click on "Edit quiz" "button"
    And I click on "Add" "link"
    And I click on "a new question" "link"
    # Cannot use the normal ‘I click on’ here, because the pop-up gets in the way.
    And I click on ".moodle-dialogue-lightbox" "css_element" skipping visibility check
    # The modal does not close because it contains a form.
    Then I should see "Choose a question type to add"

  @javascript
  Scenario: The popup closes when clicked on dead space - Modal
    Given I log in as "admin"
    And I am on site homepage
    And I click on "Calendar" "link"
    And I click on "New event" "button"
    When I click on "[data-region='modal-container']" "css_element"
    # The modal does not close becaue it contains a form.
    Then ".modal-backdrop" "css_element" should be visible
    And ".modal-content" "css_element" should be visible

  @javascript
  Scenario: The popup help closes when clicked
    Given the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |
    And the following "activities" exist:
      | activity | name           | intro                 | course | idnumber |
      | quiz     | Test quiz name | Test quiz description | C1     | quiz1    |
    And I log in as "admin"
    And I am on "Course 1" course homepage
    And I follow "Test quiz name"
    And I click on "Edit quiz" "button"
    And I click on "Help with Editing quiz" "icon"
    And I should see "More help"
    And I click on "body" "css_element"
    Then I should not see "More help"
