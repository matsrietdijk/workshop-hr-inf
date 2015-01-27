# Workshop HR - Informatica

## Prerequisites

This workshop needs the following programming languages to be available:

* Ruby v2+
* Haskell (GHC v7.8+, Cabal v1.18+)

To install all ruby dependencies for this workshop we use [Bundler](http://bundler.io). To install Bundler run the following command:

```bash
gem install bundler
```

## Setup

To setup this workshop from scratch run te following commands:

```bash
git clone https://github.com/matsrietdijk/workshop-hr-inf.git workshop
cd workshop
```

## Running the Ruby application

```bash
cd ruby
bundle install
ruby app.rb
```

## Running the Haskell application

```bash
cd haskell
cabal install
runhaskell app.hs
```
