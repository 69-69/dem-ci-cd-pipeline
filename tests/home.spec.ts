import {test, expect} from '@playwright/test';

test('Home page: Automated Regression Testing', async ({page}) => {
    // Go to the home page
    await page.goto(process.env.BASE_URL || 'http://localhost:3000');

    // Expect a title "to contain" a substring
    await expect(page).toHaveTitle(/Steve Home/);

    // Create a locator
    const getStarted = page.getByRole('link', {name: 'Home to Blog'});

    // Expect an attribute "to be strictly equal" to the value
    await expect(getStarted).toHaveAttribute('href', '/blog');
});