# OmnyStudio Client
An unofficial Ruby client for the OmnyStudio API

## Installation
```bash
gem 'omnystudio_client', github:"scpr/omnystudio_client"
```

## Usage
### Configuration
Configure your app to connect to OmnyStudio, either in an initializer or from your environment files:

```ruby
omnystudio = OmnyStudioClient.new({
  token: "{omnystudio api token}",
})
```

### Documentation

You can view OmnyStudioClient's documentation in RDoc format here:
http://www.rubydoc.info/github/SCPR/omnystudio_client/master/

## Tests

#### To run the tests:
```bash
bundle exec rspec spec
```

## Contributing

Pull Requests are encouraged! Suggested practice:
- Fork and make changes
- Submit a PR from fork to this master