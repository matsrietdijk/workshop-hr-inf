# Workshop HR - Informatica

Code base for a workshop to introduce potential new students to computer science at Hogeschool Rotterdam.

## Prerequisites

This workshop needs the following programming languages to be available:

* Ruby v2+
* Haskell (GHC v7.8+, Cabal v1.18+)

To install all ruby dependencies for this workshop we use [Bundler](http://bundler.io). To install Bundler run the following command:

```bash
gem install bundler
```

To save the minimal data that is needed for the workshop [Sqlite3](http://www.sqlite.org) is used. To install Sqlite run the following command:

```bash
sudo apt-get install sqlite3 libsqlite3-dev
```

## Setup

To setup this workshop from scratch run te following commands:

```bash
git clone https://github.com/matsrietdijk/workshop-hr-inf.git workshop
cd workshop
```

## Running the applications

To preview the default applications the applications should be run. Both applications can be visited on [http://0.0.0.0:4567](http://0.0.0.0:4567/) when running. Because both use the same port only one application can be active at a time.

### Running the Ruby application

To run the Ruby application the following commands should be executed from the projects root directory:

```bash
cd ruby
bundle install
ruby app.rb
```

### Running the Haskell application

To run the Haskell application the following commands should be executed from the projects root directory:

```bash
cd haskell
cabal install
runhaskell app.hs
```
