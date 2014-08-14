# The Challenge

This code is based off of a blog plugin we use at Bonanza. It's old, outdated, and needs to be updated.

We want to get an idea what we would end up with if we gave you this code on your first day and told you we wanted to refactor it so 1) the basic functionality works, and 2) it is consistent with Bonanza's programming ideals:

1. Keep it DRY. Duplicated code is the root of most evil. Consolidate patterns.
2. Keep consistent in conventions. Where the existing conventions are poor, commit to updating past instances before creating a piecemeal new convention.
3. Keep the code as simple as possible. Use abstraction & indirection only where there is a clear benefit (and no simpler way to achieve that benefit).

Think of your output here as a finished product that would be getting merged back into the master branch at the end of the day. Code with the idea that others will have to read & understand your result later, and you may not be on-site to explain it.

We're not expecting a complete rewrite here. What can you do to make this blog app better in a few hours?


#My Approach


	- To fix as many issues that conflicted with the ruby style guide as I could in a short period of time, I used the robocop to help me find the majority of them and there are still more.
	- My next step was to update the testing suite from what seemed to be old rails 2 code to valid rails 3 code, I fixed all the errors with the tests however there are still a couple of tests that are not passing. 
	- Finally I familiarized with the code base as much as I could in a short period of time and started fixing the bugs that were preventing me from using basic functionality of the site. Bugs such as:
		- Fixing the registration/new user page.
		- Fixing the .admin? method so that it only returned true when the current users role was admin or super_admin.
		- Adding a method for users to logout so that I could manually test how the site function for users with different roles and fix bugs accordingly.
Given more time there is a lot that I would do. There are a lot of bugs and without talking with someone who is going to be using this it is hard to prioritize what features are the most important and critical. If possible the first thing that I would do is talk to someone more familiar with the product , or the customer, and determine exactly what it is they need. I would then:
	- Fix the tests that are not passing, or fix the code to make the tests pass whatever was appropriate for the situation.
	- After taking with the “customer” of the product I would create small manageable user stories.
	- Write tests to cover as much of the current functionality as was appropriate.
	- Prioritize the user stories and determine a minimum viable product.
	- Based off of the user stories I would then write tests.
	- Implement code to make the tests pass while writing them as much as was possible.
