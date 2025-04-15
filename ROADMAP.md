# Roadmap - rails_unused

## Short term

- Analyze views (partials not rendered anywhere)
- Detect mailers not being called
- Check helpers not used in views
- Support Rails jobs not enqueued
- Detect unused rake tasks

## Mid term

- Detect unused routes in config/routes.rb
- Output as JSON or YAML (optional)
- CI integration to fail build if dead code exists
- CLI output with colors

## Long term ideas

- Detect unused assets (JS/CSS)
- Analyze by environment (dev/test/prod)
- Generate HTML report
- VSCode Extension
- Web UI for browsing reports

## Contributions welcome!

Feel free to open issues or send pull requests.
