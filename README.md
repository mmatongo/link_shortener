# URL Shortener

This is a simple URL shortener app built with Ruby on Rails that allows users to shorten long URLs into shorter, more manageable links.

## Features

- Shortens long URLs into shorter, more manageable links
- Allows users to view a list of recently created short URLs
- Tracks the number of times each short URL is clicked
- Provides basic analytics on the usage of each short URL

## Requirements

- Ruby version 3.0.0 or higher
- Rails version 6.1.3 or higher
- PostgreSQL

## Getting Started

### Clone the repository

```bash
git clone https://github.com/mmatongo/link_shortener.git
```

### Install dependencies

```bash
bundle install
```

### Create and migrate the database

```bash
rails db:create
rails db:migrate
```

### Start the Rails server

```bash
foreman start -f Procfile.dev
```

## Usage

To shorten a long URL, enter it in the input field on the home page and click "Shorten". The app will generate a short URL for you, which you can copy and share as needed.

## Contributing

Contributions are welcome! If you find a bug or have a feature request, please create an issue or submit a pull request.

## License

This app is released under the [MIT](https://opensource.org/licenses/MIT) License.
