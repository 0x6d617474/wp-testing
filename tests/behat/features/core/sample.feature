Feature: Sample

  Scenario: The login page loads
    Given I am on "/wp-login.php"
    Then I should see a "#user_login" element
    And I should see "Testing Enabled"
