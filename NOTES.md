## Ruby and Rails setup

- Install `brew`: `https://brew.sh/`
- Install `rbenv` using `brew`: `https://github.com/rbenv/rbenv`
- Install `ruby` version using `rbenv`: `rbenv install 3.1.4`
- Set global `ruby` version using `rbenv`: `rbenv global 3.1.4`
  - `https://stackoverflow.com/questions/10940736/rbenv-not-changing-ruby-version`
- Install `rails`: `https://guides.rubyonrails.org/getting_started.html`

## Rails project setup

- Create `rails` project: `rails new . --api`

---

- Create models
  - `rails g model TimeReport time_report_id:integer:uniq`
  - `rails g model TimeReportDetail time_report:belongs_to date:datetime hours_worked:float employee_id job_group`
- Add `has_many` relationships to the models
- Run migrations: `rails db:migrate`

---

- Setup routes in `routes.rb`
- Create controllers manually
  - `app/controllers/api/v1/time_reports_controller.rb`
  - `app/controllers/api/v1/time_report_details_controller.rb`
- Implement controllers

---

- Add `rspec-rails`: https://github.com/rspec/rspec-rails
- Add `factory_bot_rails`: https://github.com/thoughtbot/factory_bot_rails
- Install gems: `bundle install`
- Add RSpec helper files: `rails generate rspec:install`
- Add `spec/fixtures/files/time-report-1.csv`
- Add specs for models
  - `rails g rspec:model TimeReport`
- Add specs for controllers
  - `rails g rspec:request api/v1/time_reports`
  - `rails g rspec:request api/v1/time_report_details`
- Run all specs: `rspec spec`
- Run specific spec file: `rspec <relative path>`
