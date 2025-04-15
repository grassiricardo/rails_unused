# rails_unused

Dead code analyzer for Ruby on Rails projects.  
Simple CLI tool that finds unused controllers, models, and services in your Rails app.

## Installation

Add to your Gemfile:

```ruby
gem 'rails_unused'
```

Then execute:

```bash
bundle install
```

Or install directly:

```bash
gem install rails_unused
```

## Usage

Inside your Rails project:

```bash
bundle exec rails_unused
```

Example output:

```
Possible unused controllers:
  - Admin::LegacyController

Possible unused models:
  - OldCustomer

Possible unused services:
  - User::CleanupService
```

## How it works

| Type        | Search logic                                       |
|-------------|----------------------------------------------------|
| Controllers | Checks if class name appears in `config/routes.rb` |
| Models      | Checks if class name is referenced anywhere        |
| Services    | Checks if class name is referenced anywhere        |

## Limitations

Simple static analysis.

False positives may happen if:
- Using metaprogramming
- Dynamic class loading
- External references

Always review before deleting.

## Roadmap

See [ROADMAP.md](ROADMAP.md) for future improvements.

## Contributing

Pull requests are welcome!
