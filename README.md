# SeqAsEnum

Provides `seq_as_enum` method to define constants for sequence values. 

```ruby
require 'seq_as_enum'

class AwesomeCsv
  extend SeqAsEnum
  
  seq_as_enum :NAME, :ADDRESS, :PHONE
  # The line above will define these constants:
  # NAME = 0
  # ADDRESS = 1
  # PHONE = 2
  
  # Sample use case
  def read_csv(path)
    CSV.foreach(path) do |row|
      # You can use constants defined by SeqAsEnum
      name = row[NAME]
      address = row[ADDRESS]
      phone = row[PHONE]
      
      # Without SeqAsEnum, you might write like this:
      name = row[0]
      address = row[1]
      phone = row[2]
      
      # ...
    end
  end
end
```

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add seq_as_enum

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install seq_as_enum

## Usage

Default initial value is 0:

```ruby
seq_as_enum :NAME, :ADDRESS, :PHONE
# The line above will define these constants:
# NAME = 0
# ADDRESS = 1
# PHONE = 2
```

You can change initial value:

```ruby
seq_as_enum :NAME, :ADDRESS, :PHONE, init: 10
# The line above will define these constants:
# NAME = 10
# ADDRESS = 11
# PHONE = 12
```

String initial value is also available:

```ruby
seq_as_enum :NAME, :ADDRESS, :PHONE, init: 'a'
# The line above will define these constants:
# NAME = 'a'
# ADDRESS = 'b'
# PHONE = 'c'
```

You can specify prefix:

```ruby
seq_as_enum :NAME, :ADDRESS, :PHONE, prefix: :COL
# The line above will define these constants:
# COL_NAME = 0
# COL_ADDRESS = 1
# COL_PHONE = 2
```

You can omit separator:

```ruby
seq_as_enum :Name, :Address, :Phone, prefix: :Col, sep: false
# The line above will define these constants:
# ColName = 0
# ColAddress = 1
# ColPhone = 2
```

### data_as option 

You can get sequence values as Data object instead of constants:

```ruby 
class AwesomeCsv
  extend SeqAsEnum

  seq_as_enum :Name, :Address, :Phone, data_as: :Col
  # The line above will define Data object like this:
  # Col.Name    #=> 0
  # Col.Address #=> 1
  # Col.Phone   #=> 2

  # Sample use case
  def read_csv(path)
    CSV.foreach(path) do |row|
      # You can use Data object defined by SeqAsEnum
      name = row[Col.Name]
      address = row[Col.Address]
      phone = row[Col.Phone]

      # ...
    end
  end
end
```

NOTE: If you use Ruby 3.1.x or 3.0.x, data_as will use Struct instead of Data.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/seq_as_enum. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/seq_as_enum/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SeqAsEnum project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/seq_as_enum/blob/main/CODE_OF_CONDUCT.md).
