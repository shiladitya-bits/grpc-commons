# Grpc::Client::Commons

Set of common tools useful for gRPC communication (server & client side). Objective of this gem is to wrap certain tasks like circuit breaker, instrumentation on client side, or health API on server side.  

## Client side tools

1. Circuit breaker (using Stoplight)
2. Instrumentation of gRPC calls
3. Health check of any gPRC APIs

## Server side tools

1. Health API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'grpc-client-commons'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grpc-client-commons

## Usage (Client side)

1. Inherit this module in your generated RPC service class definition file => `X_services_pb.rb`
1. Include `GrpcCommons::GenericService` class instead of `GRPC::GenericService`
2. Set `ENV['GRPC_COMMONS_COOLOFF_INTERVAL']` = <cool-off interval to retry service call when circuit is red>