# bonz-test

This code is based off of a blog plugin we use at Bonanza. It's old, outdated, and needs to be updated.

We want to get an idea what we would end up with if we gave you this code on your first day and told you we wanted to refactor it so 1) the basic functionality works, and 2) it is consistent with Bonanza's programming ideals:

1. Keep it DRY. Duplicated code is the root of most evil. Consolidate patterns.
2. Keep consistent in conventions. Where the existing conventions are poor, commit to updating past instances before creating a piecemeal new convention.
3. Keep the code as simple as possible. Use abstraction & indirection only where there is a clear benefit (and no simpler way to achieve that benefit).

Think of your output here as a finished product that would be getting merged back into the master branch at the end of the day. Code with the idea that others will have to read & understand your result later, and you may not be on-site to explain it.

We're not expecting a complete rewrite here. What can you do to make this blog app better in a few hours?

## Instructions

1. Download the source code zip file (see the "Download ZIP" button on the right-hand side)
2. Upload the source to a new repo
3. Make your changes
4. When your changes are complete, edit this README to include:
   * A brief overview of the changes you made
   * A TODO of features/improvements/fixes you might have added if you had more time
5. Email jason@bonanza.com with a link to the repo when you're done

## Requirements

* Rails 3.2.18
* ruby ruby-2.0.0-p247
* Mysql

## Setup

1. Load the database schema with `rake db:schema:load`
2. Load the seed data with `rake db:seed`
